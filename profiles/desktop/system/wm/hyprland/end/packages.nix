{ pkgs, ... }: {

  environment.systemPackages = with pkgs;
  # with nodePackages_latest;
  # with gnome;
  # with libsForQt5;

    [
      # gui
      blueberry
      d-spy
      # figma-linux
      # kolourpaint
      # github-desktop
      icon-library
      qt5.qtimageformats
      yad

      # tools
      bat
      eza
      fd
      ripgrep
      fzf
      socat
      jq
      gojq
      acpi
      libnotify
      killall
      zip
      unzip
      starship
      showmethekey
      ydotool

      # theming tools
      gradience

      # hyprland
      brightnessctl
      cliphist
      fuzzel
      grim
      hyprpicker
      tesseract
      imagemagick
      pavucontrol
      playerctl
      swappy
      swaylock-effects
      swayidle
      slurp
      swww
      wayshot
      wlsunset
      wl-clipboard
      wf-recorder

      # langs
      nodejs
      gjs
      bun
      cargo
      go
      gcc
      typescript
      eslint
      # very important stuff
      # uwuify
    ];

}
