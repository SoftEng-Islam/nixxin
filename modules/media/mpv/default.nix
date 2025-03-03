{ config, lib, settings, pkgs, ... }:
let
  _hwdec = "vaapi"; # auto, vaapi, vdpau, cuda
  mpvConfig = ''
    input-ipc-server=/tmp/mpvsocket
    load-auto-profiles=no
    no-border
    msg-module
    msg-color
    term-osd-bar
    use-filedir-conf
    pause
    keep-open=always
    autofit-larger=100%x95%
    cursor-autohide-fs-only
    input-media-keys=no
    cursor-autohide=1000
    prefetch-playlist=yes
    force-seekable=yes

    screenshot-format=png
    screenshot-png-compression=8
    screenshot-template='~/Desktop/%F (%P) %n'
    watch-later-directory='~/.mpv/watch_later'
    write-filename-in-watch-later-config
    watch-later-options-remove=fullscreen

    hls-bitrate=max
    # script-opts=ytdl_hook-ytdl_path=/usr/local/bin/yt-dlp
  '';

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

  subtitles = ''
    demuxer-mkv-subtitle-preroll=yes
    demuxer-mkv-subtitle-preroll-secs=2
    sub-auto=fuzzy
    sub-file-paths-append=ass
    sub-file-paths-append=srt
    sub-file-paths-append=sub
    sub-file-paths-append=subs
    sub-file-paths-append=subtitles
    embeddedfonts=yes
    sub-fix-timing=no
    sub-ass-force-style=Kerning=yes
    sub-use-margins
    sub-ass-force-margins
    sub-font="Source Sans Pro Semibold"
    sub-font-size=36
    sub-color="#FFFFFFFF"
    sub-border-color="#FF262626"
    sub-border-size=3.2
    sub-shadow-offset=1
    sub-shadow-color="#33000000"
    sub-spacing=0.5
  '';

  languages = ''
    slang=enm,en,eng,de,deu,ger
    alang=ja,jp,jpn,en,eng,de,deu,ger
  '';

  audio = ''
    audio-file-auto=fuzzy
    audio-pitch-correction=yes
    volume-max=200
    volume=100
  '';

  videoOutput = ''
    tscale=oversample
    opengl-early-flush=no
    opengl-pbo=no
    icc-profile-auto
    hwdec=no
  '';

  osdConfig = ''
    osd-level=1
    osd-duration=2500
    osd-status-msg=""
    osd-font='Source Sans Pro'
    osd-font-size=32
    osd-color='#CCFFFFFF'
    osd-border-color='#DD322640'
    osd-bar-align-y=0
    osd-border-size=2
    osd-bar-h=2
    osd-bar-w=60
  '';
in {
  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };
  # https://github.com/mpv-player/mpv/wiki
  home-manager.users.${settings.user.username} = {
    # home.sessionVariables.VIDEO = "mpv";

    # Simple GTK frontend for the mpv video player
    dconf.settings = {
      "io/github/celluloid-player/celluloid" = {
        mpv-config-file =
          "file:///home/${settings.user.username}/.config/mpv/mpv.conf";
        mpv-config-enable = true;
        always-append-to-playlist = false;
      };
    };

    home.file.".config/mpv/shaders".source = ./shaders;
    # home.file.".config/mpv/mpv.conf".text = mpvConfig + "\n" + ytdlDesktop
    #   + "\n" + ytdlLaptop + "\n" + subtitles + "\n" + languages + "\n" + audio
    #   + "\n" + videoOutput + "\n" + osdConfig;

    # xdg.configFile = {
    #   "mpv/script-opts/osc.conf".text = ''
    #     windowcontrols=no
    #   '';
    # };

    programs.mpv = {
      enable = true;
      config = {
        # uosc script recommended config
        osc = false;
        border = false;

        # UI
        autofit = "70%";

        autofit-larger = "75%x75%";
        gpu-context = "auto"; # or "auto" instead of "wayland"
        hwdec-codecs = "all";
        keep-open = true;
        # osd-font = "Iosevka NF";
        pause = true;
        video-sync = "display-resample";

        # video
        vo = "gpu";
        gpu-api = "vulkan";
        # Change this to "auto" or "vaapi" for AMD
        hwdec = _hwdec; # auto, vaapi, vdpau, cuda

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
    # (mpv.override { scripts = [ mpvScripts.mpris ]; })
    mpv
    mpv-shim-default-shaders
    driversi686Linux.vdpauinfo
    gnutls
    harfbuzz
    iconv
    libass
    libavc1394
    libavif
    libmp3splt
    libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    libva
    libva-utils
    libvdpau-va-gl
    lua
    nasm
    vaapiVdpau
    vdpauinfo

    # ---- celluloid ---- #
    # Simple GTK frontend for the mpv video player
    celluloid
    (writeShellScriptBin "celluloid-hdr" "celluloid --mpv-profile=HDR $@")

  ];
}
