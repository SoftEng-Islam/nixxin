{
  ...
}:
self: {
  user.name = "Islam Ahmed";
  user.username = "softeng";
  user.email = "softeng.islam@gmail.com";

  system.hostName = "nixxin";
  system.architecture = "x86_64-linux";

  # Enable this driver so I can use the monitor mode
  modules.networking.rtl8188eus = true;
  modules.terminals.wezterm.colorScheme = "Noctalia";
  modules.browsers.google-chrome.enable = true;
}
