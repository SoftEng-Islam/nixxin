{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _i18n = settings.modules.i18n;
in {
  # -------------------------------- #
  # Internationalisation & Time Zone
  # -------------------------------- #
  # "Internationalisation" (often abbreviated as i18n) is the process of designing software, systems, or products so they can be easily adapted for different languages, regions, and cultures without requiring major changes to the code.

  # The word is long, so it's often abbreviated as i18n because there are 18 letters between the first (I) and last (N).
  #---- Key Aspects of Internationalisation (i18n):
  #---- Language Support: Making software adaptable to multiple languages.
  #---- Character Encoding: Supporting Unicode (UTF-8) to handle different scripts (e.g., English, Arabic, Chinese, etc.).
  #---- Date, Time, and Currency Formats: Adapting to different regional formats.
  #---- Text Expansion: Allowing UI elements to accommodate longer text when translated.
  #---- Right-to-Left (RTL) Support: Handling languages like Arabic or Hebrew that are written right to left.

  # Set your time zone.
  time.timeZone = _i18n.timezone;
  services.timesyncd.enable = true;
  services.chrony.enable = false;

  # NTP for automated system clock adjustments.
  services.ntp.enable = false;

  # Internationalisation Properties.
  i18n = {
    defaultLocale = _i18n.defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = _i18n.defaultLocale;
      LC_IDENTIFICATION = _i18n.defaultLocale;
      LC_MEASUREMENT = _i18n.defaultLocale;
      LC_MONETARY = _i18n.defaultLocale;
      LC_NAME = _i18n.defaultLocale;
      LC_NUMERIC = _i18n.defaultLocale;
      LC_PAPER = _i18n.defaultLocale;
      LC_TELEPHONE = _i18n.defaultLocale;
      LC_TIME = _i18n.defaultLocale;
      LC_ALL = _i18n.defaultLocale;
    };
    # Configure Input Method (IBus for GNOME)
    inputMethod = {
      enable = true;
      type = "fcitx5"; # "ibus", "fcitx5", "nabi", "uim", "hime", "kime"
      fcitx5.addons = with pkgs; [
        fcitx5-unikey
        fcitx5-with-addons
        fcitx5-configtool
        fcitx5-gtk
      ];
      # ibus.engines = [
      #   "m17n:en"  # English (US)
      #   "m17n:ara"     # Arabic using m17n engine
      # ];
    };
  };

  # Environment Variables for Input Method
  # See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
  # https://fcitx-im.org/wiki/Setup_Fcitx_5
  environment.variables = {
    # Wayland-native input frontend
    INPUT_METHOD = "fcitx";

    # Support for XWayland apps
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";

    # Do NOT set GTK_IM_MODULE (avoids that warning)
    GTK_IM_MODULE = "";

    # Defines the system language.
    LANG = _i18n.defaultLocale;
  };

  # systemd.user.services.fcitx5 = {
  #   description = "Fcitx5 IME";
  #   serviceConfig = {
  #     ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
  #     Restart = "always";
  #   };
  #   wantedBy = [ "default.target" ];
  # };

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
  systemd.services.ibus-daemon = {
    enable = true;
    description = "IBus Input Method Framework Daemon";
    restartIfChanged = false; # Prevent unnecessary restarts during rebuild.
    serviceConfig = {
      ExecStart = "${pkgs.ibus}/bin/ibus-daemon --xim --daemonize";
      Restart = "on-failure"; # Restart only on failure
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

    # ibus
    # ibus-engines.m17n
    # ibus-theme-tools
    # ibus-with-plugins

    glibcLocales
  ];
}
