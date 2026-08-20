{
  settings,
  lib,
  pkgs,
  ...
}:
# The [ MPV ] manual
# https://mpv.io/manual/stable/
lib.mkIf (settings.modules.media.mpv) {
  environment.variables = {
    VIDEO = "mpv";
  };

  # https://github.com/mpv-player/mpv/wiki
  home-manager.users.${settings.user.username} = {
    home.file.".config/mpv/shaders".source = ./shaders;
    xdg.configFile = {
      "mpv/script-opts/osc.conf".text = ''
        windowcontrols=no
      '';
    };

    xdg.configFile."mpv/script-opts/uosc.conf".text = lib.concatStrings [
      "opacity=0.5"
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
      package = pkgs.mpv.override {
        mpv-unwrapped = pkgs.mpv-unwrapped.override {
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
        # --- VIDEO OUTPUT & HARDWARE DECODING ---
        vo = "gpu-next"; # Highest quality renderer, natively uses libplacebo
        gpu-api = "vulkan"; # Best API for AMD graphics
        gpu-context = "wayland";
        hwdec = "auto-safe"; # Efficient hardware decoding without copying back to RAM
        profile = "high-quality"; # Enables advanced scaling and rendering features

        # Performance tweaks for Vulkan
        vulkan-async-compute = "yes";
        vulkan-async-transfer = "yes";
        vulkan-queue-count = 1;

        # --- SCALING & RENDERING (Max Quality) ---
        scale = "ewa_lanczossharp"; # High-quality luma upscaling
        cscale = "ewa_lanczossharp"; # High-quality chroma upscaling
        dscale = "mitchell";
        scale-antiring = 0.7;
        cscale-antiring = 0.7;
        dscale-antiring = 0.7;

        deband = "yes";
        dither-depth = "auto";
        hdr-compute-peak = "no";

        # --- SMOOTH PLAYBACK ---
        video-sync = "display-resample"; # Eliminates judder by syncing to monitor refresh rate
        interpolation = "yes";
        tscale = "oversample";
        framedrop = "vo";

        # Cache settings
        cache = "yes";
        demuxer-max-bytes = "100M";
        demuxer-readahead-secs = 5;

        # Window Behavior
        fullscreen = false;
        keep-open = "yes";
        force-window = "immediate";
        term-osd-bar = true;
        window-maximized = "yes";
        save-position-on-quit = true;

        # --- AUDIO ---
        ao = "pipewire,pulse,alsa";
        volume = 100;
        volume-max = 150;
        alang = "en,eng";
        slang = "en,eng,ar";

        # --- SUBTITLES ---
        sub-auto = "fuzzy";
        sub-font-size = 32;
        sub-outline-size = 2.5;
        sub-color = "#fffae1ff";
        sub-outline-color = "#414141ff";
        sub-use-margins = "yes";

        osd-level = 1;
        msg-color = true;
        msg-module = true;
      };

      # Adjusted profiles for new settings
      profiles = {
        "high-fps" = {
          profile-cond = "p.container_fps>=59";
          interpolation = "no";
        };
        "high-res" = {
          # Removed bilinear downgrading. Your AMD hardware can handle 1080p+ easily.
          profile-cond = "p.height>=1080";
        };
      };
      bindings = {
        z = "add sub-delay 0.1";
        x = "add sub-delay -0.1";
        Z = "add audio-delay -0.1";
        X = "add audio-delay 0.1";
        r = "add sub-pos -1";
        t = "add sub-pos +1";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    mpv-handler
    gnutls
    harfbuzz
    iconv
    libass
    libavc1394
    libavif
    libplacebo
    libva
    libva-utils
    lua
    mesa
    mpv-shim-default-shaders
    libGL
    nasm
    trash-cli
    vulkan-headers
    vulkan-loader
    vulkan-tools
  ];
}
