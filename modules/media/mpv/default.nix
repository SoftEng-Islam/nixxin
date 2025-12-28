{ config, lib, settings, pkgs, ... }:
# The [ MPV ] manual
# https://mpv.io/manual/stable/
lib.mkIf (settings.modules.media.mpv) {
  environment.variables = { VIDEO = "mpv"; };

  # https://github.com/mpv-player/mpv/wiki
  home-manager.users.${settings.user.username} = {
    home.file.".config/mpv/shaders".source = ./shaders;
    xdg.configFile = {
      "mpv/script-opts/osc.conf".text = ''
        windowcontrols=no
      '';
    };

    xdg.configFile."mpv/script-opts/uosc.conf".text = lib.concatStrings [
      "opacity="
      ",timeline=0.1"
      ",position=0.2"
      ",chapters=0.075"
      ",slider=0.1"
      ",slider_gauge=0.2"
      ",controls=0"
      ",speed=0.2"
      ",menu=1"
      ",submenu=0.4"
      ",border=1"
      ",title=1"
      ",tooltip=1"
      ",thumbnail=1"
      ",curtain=0.8"
      ",idle_indicator=0.8"
      ",audio_indicator=0.5"
      ",buffering_indicator=0.3"
      ",playlist_position=0.8"
    ];

    programs.mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped.wrapper {
        mpv = pkgs.mpv-unwrapped.override {
          ffmpeg = pkgs.ffmpeg-full;
          openalSupport = true;
          sdl2Support = true;
          vaapiSupport = true;
          waylandSupport = true;
          vdpauSupport = false;
          vapoursynthSupport = false;
          drmSupport = true;
          vulkanSupport = true;
          x11Support = false;
          cddaSupport = false;
          archiveSupport = false;
          bluraySupport = true;
          bs2bSupport = false;
          cacaSupport = false;
          cmsSupport = false;
          dvdnavSupport = false;
          dvbinSupport = false;
          jackaudioSupport = false;
          javascriptSupport = false;
          alsaSupport = true;
          pulseSupport = true;
          pipewireSupport = true;
          rubberbandSupport = false;
          sixelSupport = false;
          zimgSupport = false;
          libplacebo = pkgs.libplacebo.overrideAttrs (oldAttrs: rec {
            version = "7.349.0";
            src = pkgs.fetchFromGitLab {
              domain = "code.videolan.org";
              owner = "videolan";
              repo = "libplacebo";
              tag = "v${version}";
              hash = "sha256-mIjQvc7SRjE1Orb2BkHK+K1TcRQvzj2oUOCUT4DzIuA=";
            };
          });
        };
        scripts = with pkgs.mpvScripts; [
          mpris
          thumbfast
          uosc
          cutter
          quality-menu
          mpv-subtitle-lines
        ];
      };
      config = {
        vo = "gpu"; # mpv --vo=help

        # Allow only Vulkan (requires a valid/working --spirv-compiler)
        gpu-api = "vulkan"; # mpv --gpu-api=help
        vulkan-async-compute = "yes";
        vulkan-async-transfer = "yes";
        vulkan-queue-count = 1;

        gpu-context = "auto"; # mpv --gpu-context=help
        hwdec = "auto-safe"; # mpv --hwdec=help
        profile = "fast"; # mpv --profile=help
        dither-depth = "no";
        hdr-compute-peak = "no"; # Fix stuttering playing 4k video
        opengl-pbo = "yes";
        deband = "no";

        # Aggressive performance: fastest scaling
        scale = "bilinear";
        cscale = "bilinear";
        dscale = "bilinear";

        # Framedrop for smooth playback
        video-sync = "audio";
        framedrop = "vo";

        # Reduce decoder threads for weak CPUs
        vd-lavc-threads = 2;

        # Cache settings
        cache = "yes";
        demuxer-max-bytes = "50M";
        demuxer-readahead-secs = 5;

        # Shaders
        # glsl-shaders = [ "~~/shaders/AMD/FSR.glsl" "~~/shaders/AMD/CAS-scaled.glsl" ];

        fullscreen = false;
        keep-open = "yes";
        force-window = "immediate";
        term-osd-bar = true;
        window-maximized = "yes";
        save-position-on-quit = true;

        # Audio
        ao = "alsa,pulse,pipewire,openal"; # mpv --ao=help
        volume = 100;
        volume-max = 150;
        alang = "en,eng";
        slang = "en,eng,ar";

        # Subtitle
        sub-auto = "fuzzy";
        sub-font-size = 32;
        sub-outline-size = 2.5;
        sub-color = "#fffae1ff";
        sub-outline-color = "#414141ff";
        sub-use-margins = "yes";
        # sub-ass-override = "force";

        osd-level = 1; # ?
        msg-color = true;
        msg-module = true;
      };
      bindings = {
        z = "add sub-delay -0.1";
        x = "add sub-delay 0.1";
        Z = "add audio-delay -0.1";
        X = "add audio-delay 0.1";
        r = "add sub-pos -1";
        t = "add sub-pos +1";
      };
      # defaultProfiles = [ "high-quality" ];
    };
  };

  environment.systemPackages = with pkgs; [
    gnutls
    harfbuzz
    iconv
    libass
    libavc1394
    libavif
    libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    libva
    libva-utils # For testing VAAPI support
    lua
    mesa
    mpv-shim-default-shaders
    libGL
    nasm
    trash-cli
    libva-vdpau-driver
    vulkan-headers
    vulkan-loader
    vulkan-tools # Includes `vulkaninfo`
  ];
}
