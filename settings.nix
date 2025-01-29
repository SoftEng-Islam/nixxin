{ pkgs, ... }: rec {
  # ---------------- #
  # ---- System ---- #
  # ---------------- #
  system = {
    name = "nixos";
    hostName = "nixos"; # Hostname
    profile = "desktop"; # select a profile defined from my profiles directory
    architecture = "x86_64-linux"; # Replace with your system architecture
    stateVersion = "24.05";
    upgrade = {
      enable = true;
      allowReboot = true;
      # nix-channel --list
      channel = "https://channels.nixos.org/nixos-unstable";
    };
  };

  home = { stateVersion = "24.11"; };

  # -------------- #
  # ---- IDLE ---- #
  # -------------- #
  # For Ex: You can set the idle-delay to 300 seconds (5 minutes) or
  # 0 to Disable:
  idle = { delay = 0; };

  # -------------------- #
  # ---- Lockscreen ---- #
  # -------------------- #
  lockscreen = {
    type = "hyprlock";
    timeOut = 600;
  };

  # -------------- #
  # ---- Boot ---- #
  # -------------- #
  boot = {
    mode = "uefi"; # uefi or bios
    # mount path for efi boot partition; only used for uefi boot mode
    mountPath = "/boot";
    # device identifier for grub; only used for legacy (bios) boot mode
    grubDevice = "";
  };

  # ---- Date/Time & Languages ---- #
  timezone = "Africa/Cairo"; # Select timezone
  timeFormat = 12;
  locale = "en_US.UTF-8"; # Select locale
  mainlanguage = "English"; # Select Your Language for System and keyboard.
  languages = [ "arabic" "france" ]; # Add Other Languages that you know

  # ---- Networks ---- #
  ethernet = "eno1";
  wlanInterface = "wlp0s19f2u5";

  # ---- Hardware ---- #
  gpuType = "amd"; # amd, intel or nvidia;
  rocmSupport = (if gpuType == "amd" then true else false);
  # APU = "amd";
  # CPU = "amd";
  # StorageType = "";
  videoDrivers = [
    "amdgpu"
    # "radeon"
    # "modesetting"
    # "displaylink"
    # "ati_unfree"
  ];

  # ---- Dotfiles Inforamtions ---- #
  dotfilesDir =
    "/home/${users.user1.username}/nixxin"; # Absolute path of the local repo

  # ---- Window/Desktop Managers ---- #
  defaultSession = "hyprland"; # hyprland or gnome
  wm = [ "hyprland" ]; # Selected window manager or desktop environment;
  # wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

  # ----------------------------- #
  # ----- USER Inforamtions ----- #
  # ----------------------------- #
  users = {
    user1 = {
      name = "Islam Ahmed"; # Name/Identifier
      username = "softeng"; # Username
      email = "softeng.islam@gmail.com"; # Email (git config)
    };
    user2 = {
      name = "Iman Ahmed";
      username = "iman";
      email = "";
    };
  };

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

  # --------------- #
  # ---- Fonts ---- #
  # --------------- #
  fonts = {
    main = {
      # Exambles:
      # "JetBrainsMonoNL Nerd Font Mono"
      # "CaskaydiaCove Nerd Font Mono"
      name = "CaskaydiaCove Nerd Font Mono"; # Selected Font
      package = pkgs.nerd-fonts.caskaydia-cove; # Typeface made for developers
      size = 12; # Font size
      antialiasing = "grayscale";
    };
    monospace = {
      name = fonts.name;
      package = "";
    };
    serif = {
      name = "Noto Serif";
      package = pkgs.noto-fonts-cjk-sans;
    };
    sansSerif = {
      name = "Noto Sans";
      package = pkgs.noto-fonts-cjk-serif;
    };
    terminals = {
      kitty = {
        name = "CaskaydiaCove Nerd Font Mono";
        size = 18; # Font size
      };
    };
  };

  # ---------------- #
  # ---- Styles ---- #
  # ---------------- #
  style = {
    name = "nixxin";

    # Blue, Teal, Green, Yellow, Orange, Red, Pink, Purple, Slate
    mainColor = "red";

    # ---- Mode ---- #
    mode = "dark"; # "dark" or "light"
    colorScheme = "prefer-dark";

    # ---- Window Properties ---- #
    window = {
      title = {
        fontStyle = "bold";
        fontSize = 20;
      };
      border = {
        active = {
          color = style.mainColor;
          size = 3;
        };
        inactive = {
          color = "#ddd8";
          size = 3;
        };
      };
      opacity = 0.9; # The windows Opacity
      blur = false; # Enable blur for windows
      shadow = false; # enable shadow for Hyprland
      rounding = 10; # rounding corners for Hyprland windwos
      dim_inactive = true;
    };
    # ---- GTK ---- #
    gtk = {
      # Material
      # adw-gtk3-dark
      theme = "Material";
      package = pkgs.adw-gtk3;
    };
    # ---- Qt ---- #
    qt = {
      Style = "adwaita-dark";
      platformTheme = "qt5ct"; # (one of "gnome", "gtk2", "kde", "lxqt", "qtct")
      package = pkgs.kdePackages.breeze;
    };
    # ---- Icons ---- #
    icons = {
      nameInLight = "Papirus";
      nameInDark = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # ---- Cursor ---- #
    cursor = {
      size = 24; # Cursor Size
      name = "Bibata-Modern-Ice"; # Cursor Name
      package = pkgs.bibata-cursors;
    };
  };

  # ---- Hyprland ---- #
  hyprland = {
    enable = true;
    # Pregenerated Colors to use in Hyprland
    genColorsPath = /home/${users.user1.username}/.cache/hypr/colors.conf;
    animationSpeed = "medium"; # medium or slow
    plugins = {
      Hyprspace = true;
      hyprbars = true;
      hyprtrails = true;
      borders-plus-plus = true;
    };
  };

  # ---- Gnome ---- #
  gnome = { enable = false; };

  defaults = {
    fileManager = "nautilus"; # thunar & nautilus
    imageViewer = "loupe"; # feh or loupe
    videoPlayer = "celluloid"; # vlc or celluloid or mpv
    torrentApp = "qBittorrent";
  };
  gaming = {
    enable = true; # To support gaming and install gaming stuff
    steam = { enable = true; };
  };
}
