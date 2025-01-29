{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    home.sessionVariables.VIDEO = "mpv";
    home.file.".config/mpv/shaders".source = ./shaders;

    xdg.configFile = {
      "mpv/script-opts/osc.conf".text = ''
        windowcontrols=no
      '';
    };

    programs.mpv = {
      enable = true;
      config = {
        # uosc script recommended config
        osc = false;
        border = false;

        # UI
        autofit = "70%";

        autofit-larger = "75%x75%";
        gpu-context = "wayland";
        hwdec-codecs = "all";
        keep-open = true;
        osd-font = "Iosevka NF";
        pause = true;
        video-sync = "display-resample";

        # video
        vo = "gpu";
        gpu-api = "vulkan";
        hwdec = "vdpau"; # auto, vaapi, vdpau, cuda

        # Audio
        ao = "pipewire";
        alang = "jpn,jp,eng,en";

        # Subtitles
        slang = "eng,en,ar";
        sub-auto = "fuzzy";

        # Screenshots
        screenshot-directory = "~/Pictures";
        screenshot-template =
          "mpv-%f-%wH.%wM.%wS.%wT-#%#00n"; # name-hour-minute-second-millisecond-ssnumb

        # High-quality scaling
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";

        tscale = "oversample";
        volume-max = 200;

        # Debanding
        deband = "yes";

        # Dithering
        dither-depth = "auto";

        # AMD FidelityFX Super Resolution v1.0.2 for mpv
        glsl-shaders = "~/.config/mpv/shaders/AMD/FSR.glsl";
      };
      defaultProfiles = [
        "high-quality" # or fast
      ]; # https://github.com/mpv-player/mpv/blob/master/etc/builtin.conf
      profiles = {
        igpu-amd = {
          hwdec = "auto-safe";
          vo = "gpu";
        };
        dgpu-nvidia = {
          hwdec = "nvdec-copy";
          vo = "gpu-next";
        };
      };
      scripts = with pkgs; [
        mpvScripts.mpris
        mpvScripts.thumbfast
        mpvScripts.uosc
        mpvScripts.cutter
        mpvScripts.quality-menu
        mpvScripts.mpv-cheatsheet
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    libavc1394
    libavif
    libplacebo
    nasm
    harfbuzz
    iconv
    libass
    lua
    gnutls
    libmp3splt
  ];
}
