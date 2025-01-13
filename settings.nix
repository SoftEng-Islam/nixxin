{ pkgs, ... }: rec {
  # ------------------ #
  # ---- SETTINGS ---- #
  # ------------------ #
  system = "x86_64-linux"; # Replace with your system architecture
  hostName = "nixos"; # Hostname
  systemStateVersion = "24.05";
  homeStateVersion = "24.11";
  profile = "desktop"; # select a profile defined from my profiles directory

  # ---- Boot ---- #
  bootMode = "uefi"; # uefi or bios
  # mount path for efi boot partition; only used for uefi boot mode
  bootMountPath = "/boot";
  # device identifier for grub; only used for legacy (bios) boot mode
  grubDevice = "";

  # ---- Date/Time & Languages ---- #
  timezone = "Africa/Cairo"; # Select timezone
  timeFormat = 12;
  locale = "en_US.UTF-8"; # Select locale
  mainlanguage = "English"; # Select Your Language
  languages = [ "arabic" "france" ]; # Add Other Languages that you know

  # ---- Networks ---- #
  ethernet = "eno1";
  wlanInterface = "wlp0s19f2u5";

  # ---- Hardware ---- #
  gpuType = "amd"; # amd, intel or nvidia;
  # APU = "amd";
  # CPU = "amd";
  # StorageType = "";

  # ---- Dotfiles Inforamtions ---- #
  dotfilesDir = "/home/${username}/nixxin"; # Absolute path of the local repo

  # ---- Window/Desktop Managers ---- #
  defaultSession = "hyprland"; # hyprland or gnome
  wm = [ "hyprland" "gnome" ]; # Selected window manager or desktop environment;
  # wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

  # ----------------------------- #
  # ----- USER Inforamtions ----- #
  # ----------------------------- #
  name = "Islam Ahmed"; # Name/identifier
  username = "softeng"; # Username
  email = "softeng.islam@gmail.com"; # Email (git config)

  # ---------------------- #
  # ---- Web Browsers ---- #
  # ---------------------- #
  browser = "brave"; # Default Browser;
  browserPkg = pkgs.brave;

  # ---------------------- #
  # ---- Terminals ------- #
  # ---------------------- #
  term = "kitty"; # Default terminal command
  termPkg = pkgs.kitty;

  # ---------------------- #
  # ---- Editors --------- #
  # ---------------------- #
  editor = "nvim"; # Default editor
  visual = "nvim";
  editorPkg = pkgs.neovim;

  # ---------------------- #
  # ---- Fonts ----------- #
  # ---------------------- #
  fontAntialiasing = "grayscale";
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

  # ------------------------ #
  # ----- Styles ----------- #
  # ------------------------ #
  # Blue, Teal, Greesn, Yellow, Ornage, Red, Pink, Purple, Slate
  accentColor = "red";
  themeName = "nixxin";

  # ---- Mode ---- #
  styleMode = "dark"; # "dark" or "light"
  colorScheme = "prefer-dark";

  # ---- Window Properties ---- #
  opacity = 0.9; # The windows Opacity
  shadow = true; # enable shadow for Hyprland
  rounding = 10; # rounding corners for Hyprland windwos

  # ---- GTK ---- #
  gtkTheme = "adw-gtk3-dark";
  gtkPackage = pkgs.adw-gtk3;

  # ---- Qt ---- #
  qtPlatformTheme = "kde"; # (one of "gnome", "gtk2", "kde", "lxqt", "qtct")
  qtStyle = "adwaita-dark";

  # ---- Icons ---- #
  iconNameLight = "Papirus";
  iconNameDark = "Papirus-Dark";
  iconPackage = pkgs.papirus-icon-theme;

  # ---- Cursor ---- #
  cursorPackage = pkgs.bibata-cursors;
  cursorTheme = "Bibata-Modern-Ice"; # Cursor Name
  cursorSize = 24; # Cursor Size
}
