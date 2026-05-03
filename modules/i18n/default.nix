{ settings, pkgs, ... }:
let
  _i18n = settings.modules.i18n;
in
{
  # --------------------------------------------------------- #
  # Internationalisation & Time Zone
  # --------------------------------------------------------- #
  # "Internationalisation" (i18n) = designing software so it can be
  # easily adapted for different languages, regions, and cultures.
  # The word is abbreviated i18n (18 letters between I and N).
  #
  # Key Aspects:
  #   · Language Support      — multiple languages
  #   · Character Encoding    — Unicode / UTF-8
  #   · Date, Time, Currency  — regional formats
  #   · Text Expansion        — UI elements adapt to longer translated text
  #   · RTL Support           — Arabic, Hebrew, etc.
  # --------------------------------------------------------- #

  # ── Time Zone ────────────────────────────────────────────
  time.timeZone = _i18n.timezone;

  # ── Hardware Clock ────────────────────────────────────────
  # NixOS (and Linux in general) expects the hardware RTC to be
  # stored in UTC, then the kernel applies the timezone offset.
  #
  # Set this to `true` ONLY if you dual-boot with Windows and
  # Windows insists on keeping the hardware clock in local time.
  # Leaving it `false` (the default) is the correct choice for
  # Linux-only systems and is strongly recommended.
  time.hardwareClockInLocalTime = false;

  # ── NTP / Time Synchronisation ────────────────────────────
  # systemd-timesyncd is a lightweight SNTP client built into
  # systemd. It is sufficient for desktops and laptops and has
  # no extra dependencies. It syncs at boot and periodically
  # thereafter, and also adjusts after the system wakes from
  # suspend/hibernate.
  services.timesyncd = {
    enable = true;

    # NTP servers queried in order. The NixOS pool servers are
    # geographically load-balanced and served over anycast.
    # A regional pool (e.g. "africa.pool.ntp.org") is listed
    # first so that Cairo gets the closest stratum-1 servers;
    # the global NixOS pool entries act as fallbacks.
    extraConfig = ''
      NTP=africa.pool.ntp.org 0.nixos.pool.ntp.org 1.nixos.pool.ntp.org 2.nixos.pool.ntp.org 3.nixos.pool.ntp.org
      FallbackNTP=time.cloudflare.com time.google.com
      # Poll aggressively on first sync, then back off to save power.
      PollIntervalMinSec=32
      PollIntervalMaxSec=2048
    '';
  };

  # Disable the other NTP daemons so they don't conflict with
  # timesyncd. Chrony or ntpd are only worth enabling if you
  # need sub-millisecond accuracy (e.g. a server / time source).
  services.chrony.enable = false;
  services.ntp.enable = false;

  # ── Locale ────────────────────────────────────────────────
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

  # ── Environment ───────────────────────────────────────────
  environment.variables = {
    # Do NOT set GTK_IM_MODULE here — it causes GTK warnings
    # when using Wayland input methods.

    LANG = _i18n.defaultLocale;
    GLFW_IM_MODULE = "ibus"; # fallback IM for some games
  };
}
