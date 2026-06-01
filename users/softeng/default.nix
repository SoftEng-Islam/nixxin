{
  ...
}:
self: {
  user.name = "Islam Ahmed";
  user.username = "softeng";
  user.email = "softeng.islam@gmail.com";

  system.hostName = "nixxin";
  system.architecture = "x86_64-linux";
  modules.system.acpi.enableDSDTOverride = true;

  modules.community.enable = true;
  modules.community.telegram.enable = true;
  modules.community.ferdium.enable = false;
  modules.community.discord.enable = true;
  modules.community.mumble.enable = false;
  modules.community.revolt.enable = false;
  modules.community.signal.enable = false;
  modules.community.slack.enable = false;
  modules.community.vesktop.enable = false;
  modules.community.zoom.enable = false;

  # Enable this driver so I can use the monitor mode
  modules.networking.rtl8188eus = true;
  modules.terminals.wezterm.colorScheme = "Noctalia";
  modules.browsers.google-chrome.enable = true;

  modules.development.editors.kiro.enable = false;
  modules.development.editors.windsurf.enable = true;

  # Not perfectly working
  modules.media.kdenlive = false; # video Editor

}
