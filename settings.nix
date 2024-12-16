{ pkgs, ... }: rec {
  # ---- SYSTEM SETTINGS ---- #
  system = "x86_64-linux"; # system nixos
  hostname = "nixos"; # Hostname
  profile = "desktop"; # select a profile defined from my profiles directory
  timezone = "Africa/Cairo"; # Select timezone
  locale = "en_US.UTF-8"; # Select locale
  bootMode = "uefi"; # uefi or bios

  # mount path for efi boot partition; only used for uefi boot mode
  bootMountPath = "/boot";

  # device identifier for grub; only used for legacy (bios) boot mode
  grubDevice = "";

  gpuType = "amd"; # amd, intel or nvidia;

  # ----- USER SETTINGS ----- #
  name = "Islam Ahmed"; # Name/identifier
  email = "softeng.islam@gmail.com"; # Email (git config)
  username = "softeng"; # Username
  dotfilesDir = "/home/${username}/.nixxin"; # Absolute path of the local repo
  wm = [ "hyprland" "gnome" ]; # Selected window manager or desktop environment;

  # Web Browsers
  browser = "microsoft-edge"; # Default browser;
  browserPkg = pkgs.microsoft-edge;

  # Terminals
  term = "kitty"; # Default terminal command
  termPkg = pkgs.kitty;

  # Editors
  editor = "nvim"; # Default editor
  editorPkg = pkgs.neovim;
  visual = "nvim";

  # Fonts
  font = "JetBrains Mono"; # Selected font
  fontPkg = pkgs.jetbrains-mono; # Typeface made for developers
  fontSize = 13; # Font size

  # Themes
  theme = "nord"; # ["catppuccin","everforest","gruvbox","nord"]
  themeDetails = import (./. + "/themes/${theme}.nix") { dir = dotfilesDir; };
  colorScheme = "prefer-dark";
  gtkTheme = "Colloid-Dark";

  # Icons
  icons = "Papirus-Dark";
  iconsPkg = pkgs.papirus-icon-theme;

  # Cursor
  cursorPackage = pkgs.bibata-cursors;
  cursorTheme = "Bibata-Modern-Ice"; # Cursor Name
  cursorSize = 32; # Cursor Size
}
