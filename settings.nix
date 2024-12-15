{ pkgs, ... }: rec {
  system = "x86_64-linux";
  hostname = "nixos"; # Hostname
  username = "softeng"; # Username
  profile = "desktop"; # Select from profiles directory
  timezone = "Africa/Cairo"; # Select timezone
  locale = "en_US.UTF-8"; # Select locale
  name = "Islam Ahmed"; # Name (git config)
  email = "softeng.islam@gmail.com"; # Email (git config)
  wm = [ "hyprland" "gnome" ]; # Selected window manager or desktop environment;
  dotfilesDir = "/home/${username}/.nixxin"; # Absolute path of the local repo

  # Editors
  editor = "nvim"; # Default editor
  editorPkg = pkgs.neovim;
  # Web Browsers
  browser = "microsoft-edge"; # Default browser;
  browserPkg = pkgs.microsoft-edge;
  # Terminals
  term = "kitty"; # Default terminal command
  termPkg = pkgs.kitty;

  # ---------------------------------
  # Fonts & Themes & Icons & Cursors
  # ---------------------------------
  # Fonts
  font = "JetBrains Mono"; # Selected font
  fontPkg = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
  fontSize = 12; # Font size
  # Themes
  theme =
    "nord"; # themes directory (./themes/) ["catppuccin","everforest","gruvbox","nord"]
  themeDetails = import (./. + "/themes/${theme}.nix") { dir = dotfilesDir; };
  # Icons
  icons = "Papirus";
  iconsPkg = pkgs.papirus-icon-theme;
  # Cursor
  cursorPackage = pkgs.bibata-cursors;
  cursorTheme = "Bibata-Modern-Ice"; # Cursor Name
  cursorSize = 32; # Cursor Size
}
