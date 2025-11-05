{ pkgs, ... }: {
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

}
