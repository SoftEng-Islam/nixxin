{ pkgs, ... }: rec {
  # ---- SYSTEM SETTINGS ---- #
  system = "x86_64-linux"; # Replace with your system architecture
  hostName = "nixos"; # Hostname
  profile = "desktop"; # select a profile defined from my profiles directory
  timezone = "Africa/Cairo"; # Select timezone
  locale = "en_US.UTF-8"; # Select locale
  bootMode = "uefi"; # uefi or bios
  systemStateVersion = "24.05";
  homeStateVersion = "24.11";
  ethernet = "eno1";
  wlanInterface = "wlp0s19f2u5";

  # mount path for efi boot partition; only used for uefi boot mode
  bootMountPath = "/boot";

  # device identifier for grub; only used for legacy (bios) boot mode
  grubDevice = "";

  gpuType = "amd"; # amd, intel or nvidia;

  # ----- USER SETTINGS ----- #
  name = "Islam Ahmed"; # Name/identifier
  email = "softeng.islam@gmail.com"; # Email (git config)
  username = "softeng"; # Username
  dotfilesDir = "/home/${username}/nixxin"; # Absolute path of the local repo
  wm = [ "hyprland" "gnome" ]; # Selected window manager or desktop environment;
  wmType =
    if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
  defaultSession = "hyprland";

  # Web Browsers
  browser = "brave"; # Default Browser;
  browserPkg = pkgs.brave;

  # Terminals
  term = "kitty"; # Default terminal command
  termPkg = pkgs.kitty;

  # Editors
  editor = "nvim"; # Default editor
  visual = "nvim";
  editorPkg = pkgs.neovim;

  # Fonts
  fontName = "JetBrainsMonoNL Nerd Font Mono"; # Selected Font
  fontPackage = pkgs.nerd-fonts.jetbrains-mono; # Typeface made for developers
  monospaceFont = fontName;
  fontSize = 12; # Font size
  serifFont = "Noto Serif";
  serifPackage = pkgs.noto-fonts-cjk-sans;
  sansSerifFont = "Noto Sans";
  sansSerifPackage = pkgs.noto-fonts-cjk-serif;
  TerminalsFontName = "CaskaydiaCove Nerd Font Mono";
  TerminalsFontSize = 18; # Font size

  # ~~~~~~~~~~~~~~~~
  # ~~~~ Styles ~~~~
  # ~~~~~~~~~~~~~~~~
  themeName = "gruvbox-dark-hard";
  accentColor = "purple";
  colorScheme = "prefer-dark";
  fontAntialiasing = "grayscale";
  styleMode = "dark"; # "dark" or "light"
  rounding = 25;
  opacity = 0.9;
  shadow = true;

  # GTK
  gtkTheme = "adw-gtk3-dark";
  gtkPackage = pkgs.adw-gtk3;

  # Qt
  qtPlatformTheme = "kde"; # (one of "gnome", "gtk2", "kde", "lxqt", "qtct")
  qtStyle = "adwaita-dark";

  # Icons
  iconNameLight = "Papirus";
  iconNameDark = "Papirus-Dark";
  iconPackage = pkgs.papirus-icon-theme;

  # Cursor
  cursorPackage = pkgs.bibata-cursors;
  cursorTheme = "Bibata-Modern-Ice"; # Cursor Name
  cursorSize = 24; # Cursor Size
}
