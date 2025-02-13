{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.i18n.enable) {
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
  time.timeZone = settings.i18n.timezone;
  services.timesyncd.enable = true;
  services.chrony.enable = true;
  # Internationalisation Properties.
  i18n = {
    defaultLocale = settings.i18n.defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = settings.i18n.defaultLocale;
      LC_IDENTIFICATION = settings.i18n.defaultLocale;
      LC_MEASUREMENT = settings.i18n.defaultLocale;
      LC_MONETARY = settings.i18n.defaultLocale;
      LC_NAME = settings.i18n.defaultLocale;
      LC_NUMERIC = settings.i18n.defaultLocale;
      LC_PAPER = settings.i18n.defaultLocale;
      LC_TELEPHONE = settings.i18n.defaultLocale;
      LC_TIME = settings.i18n.defaultLocale;
      LC_ALL = settings.i18n.defaultLocale;
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

    # ibus
    # ibus-engines.m17n
    # ibus-theme-tools
    # ibus-with-plugins

  ];
}
