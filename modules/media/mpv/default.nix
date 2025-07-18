{ config, lib, settings, pkgs, ... }:
# The [ MPV ] manual
# https://mpv.io/manual/stable/
let

  # no:	always use software decoding (default)
  # auto:	enable any whitelisted hw decoder (see below)
  # auto-unsafe:	forcibly enable any hw decoder found (see below)
  # yes:	exactly the same as auto
  # auto-safe:	exactly the same as auto
  _hwdec = "auto-unsafe"; # no, auto, auto-unsafe, vaapi, vdpau, cuda

  _vo = "gpu-next"; # "gpu", "gpu-next"
  _gpu-api = "opengl"; # "opengl", "vulkan"

in lib.mkIf (settings.modules.media.mpv) {

  nixpkgs.overlays = [
    (self: super: {
      mpv-unwrapped = super.mpv-unwrapped.override {
        libbluray = super.libbluray.override {
          withAACS = true;
          withBDplus = true;
        };
      };
    })
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

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

    # xdg.configFile."mpv/script-opts/osc.conf".source = ./osc.conf;

    programs.mpv = {
      enable = true;
      config = {
        vo = _vo;
        gpu-api = _gpu-api;
        gpu-context = "wayland"; # avoid wayland, r600 better with X11
        hwdec = _hwdec; # or "no" if it fails
        hwdec-codecs = "all";
        profile = "gpu-hq"; # good baseline
        fullscreen = false;
        keep-open = "yes";
        force-window = "immediate";
        term-osd-bar = true;
        scale = "bilinear"; # faster than lanczos
        cscale = "bilinear";
        tscale = "linear";
        deband = "no"; # save GPU cycles
        dither-depth = "auto";

        # Fix stuttering playing 4k video
        hdr-compute-peak = "no";

        ao = "alsa"; # or "alsa"
        volume = 100;
        volume-max = 150;
        alang = "en,eng";
        slang = "en,eng,ar";

        sub-auto = "fuzzy";
        sub-font-size = 32;
        sub-border-size = 2.5;

        osd-level = 1;
        msg-color = true;
        msg-module = true;
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
    libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    libva
    libva-utils # For testing VAAPI support
    libvdpau-va-gl
    lua
    mesa

    mpv-unwrapped

    mpv
    mpv-shim-default-shaders
    libGL
    libva
    libva-utils
    nasm
    trash-cli
    vaapiVdpau
    vdpauinfo
    vulkan-headers
    vulkan-loader
    vulkan-tools # Includes `vulkaninfo`
  ];
}
