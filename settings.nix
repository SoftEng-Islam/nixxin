{ pkgs, ... }: rec {
  # ------------------ #
  # ---- SETTINGS ---- #
  # ------------------ #
  system = "x86_64-linux"; # Replace with your system architecture
  hostName = "nixos"; # Hostname
  systemStateVersion = "24.05";
  homeStateVersion = "24.11";
  profile = "desktop"; # select a profile defined from my profiles directory

  # For Ex: You can set the idle-delay to 300 seconds (5 minutes) or
  # 0 to Disable:
  idleDelay = 0;

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
  rocmSupport = false; # or use (if gpuType == "amd" then true else false);
  # APU = "amd";
  # CPU = "amd";
  # StorageType = "";
  videoDrivers = [
    #  "radeon"
    "amdgpu"
    # "modesetting"
    # "displaylink"
    # "ati_unfree"
  ];

  # ---- Dotfiles Inforamtions ---- #
  dotfilesDir = "/home/${username}/nixxin"; # Absolute path of the local repo

  # ---- Window/Desktop Managers ---- #
  defaultSession = "hyprland"; # hyprland or gnome
  wm = [ "hyprland" ]; # Selected window manager or desktop environment;
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
  # "JetBrainsMonoNL Nerd Font Mono"
  # "CaskaydiaCove Nerd Font Mono"
  fontName = "CaskaydiaCove Nerd Font Mono"; # Selected Font
  fontPackage = pkgs.nerd-fonts.caskaydia-cove; # Typeface made for developers
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
  # flase: disabled
  # true: enabled
  opacity = 0.9; # The windows Opacity
  blur = false; # Enable blur for windows
  shadow = false; # enable shadow for Hyprland
  rounding = 10; # rounding corners for Hyprland windwos
  dim_inactive = true;

  # ---- GTK ---- #
  # Material
  # adw-gtk3-dark
  gtkTheme = "Material";
  # gtkPackage = pkgs.adw-gtk3;

  # ---- Qt ---- #
  qtPlatformTheme = "qt5ct"; # (one of "gnome", "gtk2", "kde", "lxqt", "qtct")
  qtStyle = "adwaita-dark";
  qtPackage = pkgs.kdePackages.breeze;

  # ---- Icons ---- #
  iconNameLight = "Papirus";
  iconNameDark = "Papirus-Dark";
  iconPackage = pkgs.papirus-icon-theme;

  # ---- Cursor ---- #
  cursorPackage = pkgs.bibata-cursors;
  cursorTheme = "Bibata-Modern-Ice"; # Cursor Name
  cursorSize = 24; # Cursor Size

  # ---- Hyprland ---- #
  hyprland = {
    enable = true;
    # Generated Colors to use in Hyprland
    genColorsPath = /home/${username}/.cache/hypr/colors.conf;
    # List Of Plugins to Enable to disable
    animationSpeed = "medium"; # medium or slow
    plugins = {
      Hyprspace = true;
      hyprbars = true;
      hyprtrails = true;
      borders-plus-plus = true;
    };
  };

  # ---- Gnome ---- #
  # You can access the value like this:
  # settings.gnome.enable
  gnome = {
    enable = false;
    accentColor = "red";
  };

  desktopPreferances = {
    fileManager = "thunar"; # thunar & nautilus
    imageViewer = "loupe"; # feh or loupe
    videoPlayer = "celluloid"; # vlc or celluloid or mpv
    torrentApp = "qBittorrent";
  };
}
