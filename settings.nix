{ pkgs, ... }: rec {
  system = "x86_64-linux";
  hostname = "nixos"; # Hostname
  username = "softeng"; # Username
  profile = "desktop"; # Select from profiles directory
  timezone = "Africa/Cairo"; # Select timezone
  locale = "en_US.UTF-8"; # Select locale
  name = "Islam Ahmed"; # Name (git config)
  email = "softeng.islam@gmail.com"; # Email (git config)
  dotfilesDir = "/home/${username}/.nixxin"; # Absolute path of the local repo
  theme = "nord"; # Selected theme from themes directory (./themes/)
  themeDetails = import (./. + "/themes/${theme}.nix") { dir = dotfilesDir; };
  wm = [ "hyprland" ]; # Selected window manager or desktop environment;
  # must select one in both ./user/wm/ and ./system/wm/
  # Note, that first WM is included into work profile
  # second one includes both.

  font = "JetBrains Mono"; # Selected font
  fontPkg = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
  fontSize = 12; # Font size

  icons = "Papirus";
  iconsPkg = pkgs.papirus-icon-theme;

  # Session variables.
  editor = "nvim"; # Default editor
  editorPkg = pkgs.neovim;
  browser =
    "microsoft-edge"; # Default browser; must select one from ./user/app/browser/
  browserPkg = pkgs.microsoft-edge;
  term = "kitty"; # Default terminal command
  termPkg = pkgs.kitty;
}
