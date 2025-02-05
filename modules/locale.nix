{ settings, pkgs, ... }: {
  #. Sometimes cached data or corrupt configuration files cause issues.
  # rm -rf ~/.cache/fontconfig && rm -rf ~/.config/ibus && fc-cache -fv
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      # ---- Main Font ---- #
      settings.fonts.main.package

      # ---- Extra Fonts ---- #
      fira-code # Monospace font with programming ligatures
      google-fonts
      roboto # Roboto family of fonts
      texlivePackages.fira # Fira fonts with LaTeX support

      # ---- Noto Fonts ---- #
      noto-fonts # Beautiful and free fonts for many languages
      noto-fonts-emoji # Color emoji font
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      # ---- Nerd Fonts ---- #
      nerd-fonts.caskaydia-cove
      nerd-fonts.monaspace
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.style = settings.fonts.main.hinting;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "${settings.fonts.serif.name}" ];
        sansSerif = [ "${settings.fonts.sansSerif.name}" ];
        monospace = [ "${settings.fonts.monospace.name}" ];
      };
    };
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Internationalisation & Time Zone
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Set your time zone.
  time.timeZone = settings.timezone;
  services.timesyncd.enable = true;
  services.chrony.enable = true;
  # Internationalisation Properties.
  i18n = {
    defaultLocale = settings.locale;
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_ALL = settings.locale;
    };
    # Configure Input Method (IBus for GNOME)
    inputMethod = {
      enable = true;
      type = "fcitx5"; # "ibus", "fcitx5", "nabi", "uim", "hime", "kime"
      fcitx5.addons = with pkgs; [ fcitx5-unikey fcitx5-with-addons ];
      # ibus.engines = [
      #   "m17n:en"  # English (US)
      #   "m17n:ara"     # Arabic using m17n engine
      # ];
    };
  };

  # Environment Variables for Input Method
  # See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
  environment.variables = {
    GLFW_IM_MODULE = "ibus";
    SDL_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Configure Virtual Console
  console = {
    enable = true;
    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    # useXkbConfig = false; # If set, configure the virtual console keymap from the xserver keyboard settings.
    colors = [
      "002b36"
      "dc322f"
      "859900"
      "b58900"
      "268bd2"
      "d33682"
      "2aa198"
      "eee8d5"
      "002b36"
      "cb4b16"
      "586e75"
      "657b83"
      "839496"
      "6c71c4"
      "93a1a1"
      "fdf6e3"
    ];
  };
  # IBus Daemon as a User Service
  systemd.user.services.ibus-daemon = {
    enable = true;
    description = "IBus Input Method Framework Daemon";
    serviceConfig = {
      ExecStart = "${pkgs.ibus}/bin/ibus-daemon --xim --daemonize";
      Restart = "always";
    };
    wantedBy = [ "default.target" ]; # Ensures it starts on user session login
  };
  # Include IBus in System Packages
  environment.systemPackages = with pkgs; [
    fcitx5
    fcitx5-skk-qt
    fcitx5-m17n
    fcitx5-configtool
    fcitx5-fluent
    fcitx5-gtk
    fontconfig # Library for font customization and configuration

    font-manager

    # ibus
    # ibus-engines.m17n
    # ibus-theme-tools
    # ibus-with-plugins
    # spell-checkers
    # aspell
    # aspellDicts.de
    # aspellDicts.fr
    # aspellDicts.en
    # hunspell
    # hunspellDicts.en-gb-ise

    # Latex
    texliveFull # TeX Live environment
    texlive.combined.scheme-full # TeX Live environment for scheme-full
  ];
}
