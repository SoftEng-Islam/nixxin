{ config, lib, settings, pkgs, ... }:
let
  _hwdec = "vaapi"; # auto, vaapi, vdpau, cuda
  _vo = "gpu"; # "gpu", "gpu-next"

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
    hwdec=${_hwdec}
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
    # ls /run/opengl-driver/lib/dri/
    # vainfo

    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    VIDEO = "mpv";

    # vblank_mode = "0"; # ? Reduces latency
  };
  # https://github.com/mpv-player/mpv/wiki
  home-manager.users.${settings.user.username} = {

    # Simple GTK frontend for the mpv video player
    home.file.".config/celluloid/celluloid.conf".text = ''
      # Guide https://github.com/mpv-player/mpv/issues/10565
      # Because we want high quality
      profile=gpu-hq
      # Because it can play DoVi and is faster
      vo=gpu-next
      # Hardware acceleration (faster, less energy consumption)
      hwdec=${_hwdec}
      # Force modern standards
      gpu-api=vulkan
      gpu-context=waylandvk

      # Interpolation because 24hz videos look way better
      video-sync=display-resample
      interpolation=yes

      # HDR passtrough: Important for HDR & DoVi playback, no downside for SDR so always on
      target-colorspace-hint=yes

      [HDR] # Dolby Video HDR profile
      profile-restore=copy
      target-trc=pq
      target-prim=bt.2020
      # Adjust this to the peak brightness of your display
      target-peak=1000

      # Prefer Japanese audio when available (for anime)
      alang=Japanese,jpn,ja,English,eng,en
      # Force enable English subtitles
      slang=English,eng,en

      glsl-shaders-append="~/.config/celluloid/shaders/AMD/FSR.glsl"
    '';
    home.file.".config/celluloid/shaders/".source = ./shaders;

    dconf.settings = {
      "io/github/celluloid-player/celluloid" = {
        mpv-config-file =
          "file:///home/${settings.user.username}/.config/celluloid/celluloid.conf";
      };

      "io/github/celluloid-player/celluloid" = { mpv-config-enable = true; };

      "io/github/celluloid-player/celluloid" = {
        always-append-to-playlist = true;
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
      config = {
        fullscreen = false;

        # Subtitles
        slang = "eng,en,ar";
        sub-auto = "fuzzy";
        # sub-font = "Noto Sans CJK JP Medium";
        sub-blur = 10;
        # sub-file-paths = "subs:subtitles:字幕";

        screenshot-format = "png";

        title = "\${filename} - mpv";
        script-opts =
          "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";

        osc = "no";
        osd-on-seek = "no";
        osd-bar = "no";
        osd-bar-w = 30;
        osd-bar-h = "0.2";
        osd-duration = 750;

        really-quiet = "yes";
        autofit = "65%";

        border = false;
        autofit-larger = "75%x75%";
        gpu-context = "auto"; # or "auto" instead of "wayland"
        hwdec-codecs = "all";
        keep-open = true;
        pause = false;
        video-sync = "display-resample";

        # video
        vo = _vo;
        gpu-api = "vulkan";
        # Change this to "auto" or "vaapi" for AMD
        hwdec = _hwdec; # auto, vaapi, vdpau, cuda

        # Audio
        ao = "pipewire";
        alang = "jpn,jp,eng,en";

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
