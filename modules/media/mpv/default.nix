{ config, lib, settings, pkgs, ... }:
# The [ MPV ] manual
# https://mpv.io/manual/stable/
let

  # no:	always use software decoding (default)
  # auto:	enable any whitelisted hw decoder (see below)
  # auto-unsafe:	forcibly enable any hw decoder found (see below)
  # yes:	exactly the same as auto
  # auto-safe:	exactly the same as auto
  _hwdec = "vaapi"; # no, auto, auto-unsafe, vaapi, vdpau, cuda

  _vo = "gpu"; # "gpu", "gpu-next"
  _gpu-api = "opengl"; # "opengl", "vulkan"

in lib.mkIf (settings.modules.media.mpv) {
  environment.variables = {
    # ls /run/opengl-driver/lib/dri/
    # vainfo
    VIDEO = "mpv";
    # vblank_mode = "0"; # ? Reduces latency
  };
  # https://github.com/mpv-player/mpv/wiki
  home-manager.users.${settings.user.username} = {

    home.file.".config/mpv/shaders".source = ./shaders;
    # home.file.".config/mpv/mpv.conf".text = mpvConfig + "\n" + ytdlDesktop
    #   + "\n" + ytdlLaptop + "\n" + subtitles + "\n" + languages + "\n" + audio
    #   + "\n" + videoOutput + "\n" + osdConfig;

    # xdg.configFile = {
    #   "mpv/script-opts/osc.conf".text = ''
    #     windowcontrols=no
    #   '';
    # };

    # xdg.configFile."mpv/script-opts/uosc.conf".text = lib.concatStrings [
    #   "opacity="
    #   ",timeline=0.1"
    #   ",position=0.2"
    #   ",chapters=0.075"
    #   ",slider=0.1"
    #   ",slider_gauge=0.2"
    #   ",controls=0"
    #   ",speed=0.2"
    #   ",menu=1"
    #   ",submenu=0.4"
    #   ",border=1"
    #   ",title=1"
    #   ",tooltip=1"
    #   ",thumbnail=1"
    #   ",curtain=0.8"
    #   ",idle_indicator=0.8"
    #   ",audio_indicator=0.5"
    #   ",buffering_indicator=0.3"
    #   ",playlist_position=0.8"
    # ];
    xdg.configFile."mpv/script-opts/osc.conf".source = ./osc.conf;

    programs.mpv = {
      enable = true;

      config = {
        # ▶️ Playback
        fullscreen = false;
        pause = false;
        keep-open = "yes";
        input-ipc-server = "/tmp/mpvsocket";
        force-window = "immediate";
        really-quiet = true;
        input-media-keys = "no";
        cursor-autohide = 1000;
        prefetch-playlist = "yes";
        watch-later-directory = "~/.mpv/watch_later";
        write-filename-in-watch-later-config = true;
        watch-later-options-remove = "fullscreen";

        # 📼 Video Output
        vo = "gpu";
        gpu-api = "opengl";
        gpu-context = "auto";
        hwdec = "vaapi";
        hwdec-codecs = "all";
        video-sync = "display-resample";
        interpolation = true;
        tscale = "oversample";
        deband = true;
        dither-depth = "auto";
        autofit = "100%x95%";
        autofit-larger = "100%x95%";

        # 🎞️ Scaling
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
        dscale = "mitchell";

        # 🖼️ Screenshots
        screenshot-format = "png";
        screenshot-png-compression = 8;
        screenshot-template = "~/Desktop/%F (%P) %n";
        screenshot-directory = "~/Pictures";

        # 🔤 Subtitles
        sub-auto = "fuzzy";
        sub-use-margins = true;
        sub-ass-force-margins = true;
        sub-ass-style-overrides = "Kerning=yes";
        sub-font = "Noto Sans CJK JP Medium";
        sub-font-size = 36;
        sub-spacing = 0.5;
        sub-blur = 10;
        sub-border-color = "#FF262626";
        sub-border-size = 3.2;
        sub-color = "#FFFFFFFF";
        sub-shadow-color = "#33000000";
        sub-shadow-offset = 1;
        slang = "eng,en,ar";
        embeddedfonts = true;

        # 🔊 Audio
        ao = "pipewire";
        audio-pitch-correction = true;
        audio-file-auto = "fuzzy";
        alang = "eng,en";
        volume = 100;
        volume-max = 200;

        # 🖥️ OSD/UI
        osc = "no";
        osd-bar = "no";
        osd-level = 1;
        osd-on-seek = "no";
        term-osd-bar = true;
        msg-color = true;
        msg-module = true;
        title = "\${filename} - mpv";

        # 📺 Streaming
        hls-bitrate = "max";

        # 🎨 Shaders (optional)
        glsl-shaders = "~/.config/mpv/shaders/AMD/FSR.glsl";

        # 📁 Config behavior
        use-filedir-conf = true;
        load-auto-profiles = "no";

        # 📜 Script options
        script-opts =
          "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";
      };

      defaultProfiles = [ "high-quality" ];

      scripts = with pkgs.mpvScripts; [
        mpris
        thumbfast
        uosc
        cutter
        quality-menu
        mpv-cheatsheet
        mpv-subtitle-lines
      ];
    };

  };

  # system.build.mesaPkg = pkgs.mesa;
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     mesa = prev.mesa.overrideAttrs (old: {
  #       eglPlatforms = [ "wayland" ];
  #       mesonFlags = (old.mesonFlags or [ ]) ++ [
  #         "-Dgallium-xa=disabled" # Explicitly disable gallium-xa
  #       ];
  #     });
  #   })
  # ];

  environment.systemPackages = with pkgs; [
    driversi686Linux.vdpauinfo
    ffmpeg-full # Full ffmpeg with hwaccel support
    gnutls
    harfbuzz
    iconv
    libass
    libavc1394
    libavif
    libmp3splt
    libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    libva
    libva-utils # For testing VAAPI support
    libvdpau-va-gl
    lua
    mesa
    mesa.drivers # Ensures all Mesa drivers are available
    mpv
    mpv-shim-default-shaders
    nasm
    trash-cli
    vaapiVdpau
    vdpauinfo
    vulkan-loader
    vulkan-tools # Includes `vulkaninfo`
    libva-utils
    vulkan-headers
  ];
}
