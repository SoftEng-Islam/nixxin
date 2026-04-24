{ settings, pkgs, ... }:
let _i18n = settings.modules.i18n;
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
  };

  environment.variables = {
    # Do NOT set GTK_IM_MODULE (avoids that warning)
    # GTK_IM_MODULE = lib.mkForce "";

    # Defines the system language.
    LANG = _i18n.defaultLocale;

    GLFW_IM_MODULE = "ibus"; # fallback for some games
  };

}
