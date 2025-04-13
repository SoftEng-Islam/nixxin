{ config, lib, settings, pkgs, ... }:

let
  _hwdec = "auto"; # auto, vaapi, vdpau, cuda
  _vo = "gpu-next"; # "gpu", "gpu-next"
  _gpu-api = "vulkan"; # "opengl", "vulkan"
  ytdlDesktop = ''
    [ytdl-desktop]
    profile-desc=cond:dedicated_gpu()
    ytdl-format=bestvideo[height<=?2160]+bestaudio/best
  '';

  ytdlLaptop = ''
    [ytdl-laptop]
    profile-desc=cond:not dedicated_gpu()
    ytdl-format=bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9][protocol!=http_dash_segments]+bestaudio/best
  '';
  languages = ''
    slang=enm,en,eng,de,deu,ger
    alang=ja,jp,jpn,en,eng,de,deu,ger
  '';

in lib.mkIf (settings.modules.media.mpv) {
  environment.variables = {
    # ls /run/opengl-driver/lib/dri/
    # vainfo

    # LIBVA_DRIVER_NAME = "radeonsi"; # ?
    # VDPAU_DRIVER = "radeonsi"; # ?
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
        fullscreen = false;
        input-ipc-server = "/tmp/mpvsocket";
        load-auto-profiles = "no";
        # no-border = true;
        # top_bar = "no-border"; #! Error parsing option top_bar (option not found)
        msg-module = true;
        msg-color = true;
        term-osd-bar = true;
        use-filedir-conf = true;
        keep-open = "always";
        autofit-larger = "100%x95%";
        cursor-autohide-fs-only = true;
        input-media-keys = "no";
        cursor-autohide = 1000;
        prefetch-playlist = "yes";
        force-seekable = "yes";

        # Screenshots
        screenshot-format = "png";
        screenshot-png-compression = 8;
        screenshot-template = "~/Desktop/%F (%P) %n";
        screenshot-directory = "~/Pictures";
        watch-later-directory = "~/.mpv/watch_later";
        write-filename-in-watch-later-config = true;
        watch-later-options-remove = "fullscreen";

        hls-bitrate = "max";
        # script-opts=ytdl_hook-ytdl_path=/usr/local/bin/yt-dlp

        # Subtitles
        # sub-file-paths = "subs:subtitles:字幕";
        # sub-file-paths-append = "ass";
        # sub-file-paths-append = "srt";
        # sub-file-paths-append = "sub";
        # sub-file-paths-append = "subs";
        # sub-file-paths-append = "subtitles";
        # sub-font = "Noto Sans CJK JP Medium";
        # sub-font="Source Sans Pro Semibold";
        demuxer-mkv-subtitle-preroll = "yes";
        demuxer-mkv-subtitle-preroll-secs = 2;
        slang = "eng,en,ar";
        sub-ass-force-margins = true;
        sub-ass-style-overrides = "Kerning=yes";
        sub-auto = "fuzzy";
        sub-blur = 10;
        sub-border-color = "#FF262626";
        sub-border-size = 3.2;
        sub-color = "#FFFFFFFF";
        sub-fix-timing = "no";
        sub-font-size = 36;
        sub-shadow-color = "#33000000";
        sub-shadow-offset = 1;
        sub-spacing = 0.5;
        sub-use-margins = true;

        embeddedfonts = "yes";

        title = "\${filename} - mpv";
        script-opts =
          "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";

        # osd-font = 'Source Sans Pro';
        osc = "no";
        osd-bar = "no";
        # osd-bar-align-y = 0;
        # osd-bar-h = "0.2";
        # osd-bar-w = 30;
        # osd-border-color = "#DD322640";
        # osd-border-size = 2;
        # osd-color = "#CCFFFFFF";
        # osd-duration = 750;
        # osd-font-size = 32;
        # osd-level = 1;
        osd-on-seek = "no";
        # osd-status-msg = "";

        gpu-context = "auto"; # or "auto" instead of "wayland"
        video-sync = "display-resample";
        hwdec-codecs = "all";
        really-quiet = "yes";
        autofit = "65%";
        pause = false;

        # video
        vo = _vo;
        gpu-api = _gpu-api; # "opengl", "vulkan"
        # Change this to "auto" or "vaapi" for AMD
        hwdec = _hwdec; # auto, vaapi, vdpau, cuda

        tscale = "oversample";
        opengl-early-flush = "no";
        opengl-pbo = "no";
        icc-profile-auto = false;

        # Audio
        ao = "pipewire";
        alang = "eng,en";
        audio-file-auto = "fuzzy";
        audio-pitch-correction = "yes";
        volume-max = 200;
        volume = 100;

        # High-quality scaling
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";

        # Debanding
        deband = "yes";

        # Dithering
        dither-depth = "auto";

        # AMD FidelityFX Super Resolution v1.0.2 for mpv
        glsl-shaders = "~/.config/mpv/shaders/AMD/FSR.glsl";
      };
      # https://github.com/mpv-player/mpv/blob/master/etc/builtin.conf
      defaultProfiles = [
        "high-quality" # or fast
      ];

      scripts = with pkgs; [
        mpvScripts.mpris
        mpvScripts.thumbfast
        mpvScripts.uosc
        mpvScripts.cutter
        mpvScripts.quality-menu
        mpvScripts.mpv-cheatsheet
        mpvScripts.mpv-subtitle-lines
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
