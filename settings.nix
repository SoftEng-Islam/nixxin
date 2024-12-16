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
  username = "softeng"; # Username
  name = "Islam Ahmed"; # Name/identifier
  email = "softeng.islam@gmail.com"; # Email (git config)
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
  fontPkg = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
  fontSize = 13; # Font size

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
