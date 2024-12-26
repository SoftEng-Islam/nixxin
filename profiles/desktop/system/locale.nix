{ mySettings, pkgs, ... }: {
  #. Sometimes cached data or corrupt configuration files cause issues.
  # rm -rf ~/.cache/fontconfig && rm -rf ~/.config/ibus
  # fc-cache -fv
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      mySettings.fontPackage
      dejavu_fonts # Typeface family based on the Bitstream Vera fonts
      fira-code # Monospace font with programming ligatures
      mononoki # Font for programming and code review
      roboto # Roboto family of fonts
      # texlivePackages.fira # Fira fonts with LaTeX support
      font-awesome # Font Awesome - OTF font
      hack-font # Typeface designed for source code
      inter # Typeface specially designed for user interfaces
      noto-fonts # Beautiful and free fonts for many languages

      noto-fonts-emoji # Color emoji font
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      google-fonts
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.style = "full";
      defaultFonts = {
        monospace = [ "${mySettings.monospaceFont}" ];
        sansSerif = [ "${mySettings.sansSerifFont}" ];
        serif = [ "${mySettings.serifFont}" ];
      };
    };
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Internationalisation & Time Zone
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Set your time zone.
  time.timeZone = mySettings.timezone;
  services.timesyncd.enable = true;
  services.chrony.enable = true;
  # Internationalisation Properties.
  i18n = {
    defaultLocale = mySettings.locale;
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
      LC_ALL = mySettings.locale;
    };
    # Configure Input Method (IBus for GNOME)
    inputMethod = {
      enable = true;
      type = "ibus";
      # ibus.engines = [
      #   "m17n:en"  # English (US)
      #   "m17n:ara"     # Arabic using m17n engine
      # ];
    };
  };

  # Environment Variables for Input Method
  environment.variables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
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

    fontconfig # Library for font customization and configuration
    ibus
    ibus-engines.m17n
    ibus-theme-tools
    ibus-with-plugins
    # spell-checkers
    # aspell
    # aspellDicts.de
    # aspellDicts.fr
    # aspellDicts.en
    # hunspell
    # hunspellDicts.en-gb-ise
  ];
}
