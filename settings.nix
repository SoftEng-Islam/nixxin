{ pkgs, ... }: rec {
  # ---------------------------------------------- #
  # ---- System Information And Configuration ---- #
  # ---------------------------------------------- #
  system = {
    name = "nixos";
    hostName = "nixos"; # Hostname
    profile = "desktop"; # select a profile defined from my profiles directory
    architecture = "x86_64-linux"; # Replace with your system architecture
    stateVersion = "24.05";
    upgrade = {
      enable = true;
      allowReboot = true;
      # Run `nix-channel --list` to get channels
      channel = "https://channels.nixos.org/nixos-unstable";
    };
    features = {
      android = {
        development_stuff = true;
        android_studio = false;
      };
      apps_launcher = {
        albert = true;
        ulauncher = false;
      };
      btop = { enable = true; };
      corectrl = true;
      fcitx5 = true;
      ssh = true;
      wine = true;
      zram = true;
      ai = { enable = true; };
    };
    videoEditors = {
      kdenlive = true;
      shotcut = true;
      davinci-resolve = false;
    };
    mediaPlayers = {
      mpv = true;
      celluloid = true;
      vlc = true;
      clapper = false;
      glide = false;
      jellyfin = false;
    };
    graphics = {
      lunacy = true;
      drawio = true;
      figmaLinux = false;
      gimp = true;
      blender = true;
      inkscape = false;
      darktable = false;
    };
  };

  # -------------- #
  # ---- HOME ---- #
  # -------------- #
  home = {
    stateVersion = "24.11";
    backupFileExtension = null;
  };

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
    boot_manager = "grub";
    # mount path for efi boot partition; only used for uefi boot mode
    mountPath = "/boot";
    # device identifier for grub; only used for legacy (bios) boot mode

    # List all the devices with their by-id symlinks
    # ls -l /dev/disk/by-id/
    gfxmodeEfi = "1920x1080";
    devices = [ "nodev" ];
    device = "nodev"; # Let GRUB automatically detect EFI
    grub = { oSProber = false; };
  };

  # ---- Date/Time & Languages ---- #
  timezone = "Africa/Cairo"; # Select timezone
  timeFormat = 12;
  locale = "en_US.UTF-8"; # Select locale
  mainlanguage = "English"; # Select Your Language for System and keyboard.
  languages = [ "arabic" "france" ]; # Add Other Languages that you know

  # ------------------ #
  # ---- Networks ---- #
  # ------------------ #
  ethernet = "eno1";
  wlanInterface = "wlp0s19f2u5";

  # ------------------ #
  # ---- Hardware ---- #
  # ------------------ #
  hardware = {
    # CPU Information
    cpu = {
      vendor = "amd"; # amd, intel, or other
      model = "Ryzen 7 5800X"; # Example model
      cores = 8; # Number of cores
      threads = 16; # Number of threads
    };

    # GPU Information
    gpu = {
      vendor = "amd"; # amd, intel, or nvidia
      model = "Radeon RX 6700 XT"; # Example model
      bus = "pcie"; # pcie, agp, etc.
      vram = "12GB"; # Video RAM
    };

    # APU Information (if applicable)
    apu = {
      enabled = true; # Whether an APU is present
      vendor = "amd"; # amd or intel
      model = "Ryzen 7 5700G"; # Example model
    };

    # ROCm Support (for AMD GPUs)
    rocmSupport = hardware.gpu.vendor == "amd";

    # Storage Information
    storage = {
      type = "nvme"; # nvme, sata, hdd, ssd, etc.
      model = "Samsung 970 EVO Plus"; # Example model
      capacity = "1TB"; # Storage capacity
    };

    # Video Drivers (based on GPU vendor)
    videoDrivers = if hardware.gpu.vendor == "amd" then
      [ "amdgpu" ] # Default driver for AMD GPUs
    else if hardware.gpu.vendor == "nvidia" then
      [ "nvidia" ] # Default driver for NVIDIA GPUs
    else if hardware.gpu.vendor == "intel" then
      [ "modesetting" ] # Default driver for Intel GPUs
    else
      [ "modesetting" ]; # Fallback driver

    # Network Adapters
    networkAdapters = [
      {
        type = "wifi";
        vendor = "intel";
        model = "Intel Wi-Fi 6 AX200";
      }
      {
        type = "ethernet";
        vendor = "realtek";
        model = "RTL8111/8168/8411";
      }
    ];

    # Audio Information
    audio = {
      vendor = "realtek";
      model = "ALC1220";
      driver = "snd_hda_intel"; # Example driver
    };

    # RAM Information
    memory = {
      size = "32GB"; # Total RAM size
      type = "DDR4"; # RAM type
      speed = "3200MHz"; # RAM speed
    };

    # Motherboard Information
    motherboard = {
      vendor = ""; # Ex. ASUS
      model = ""; # Ex. ROG Strix X570-E Gaming
    };

    # Power Supply Information
    powerSupply = {
      wattage = "750W";
      efficiency = "80+ Gold";
    };

    # Cooling Information
    cooling = {
      cpuCooler = "Noctua NH-D15";
      caseFans = [
        {
          size = "120mm";
          speed = "1200 RPM";
        }
        {
          size = "140mm";
          speed = "1000 RPM";
        }
      ];
    };
  };

  # ---- Window/Desktop Managers ---- #
  defaultSession = "hyprland"; # hyprland or gnome
  wm = [ "hyprland" ]; # Selected window manager or desktop environment;
  wmType =
    if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

  # ---- Desktop Environment ---- #
  gnome = { enable = false; };
  COSMIC = { enable = false; };
  plasma = { enable = false; };

  # ---- Hyprland ---- #
  hyprland = {
    enable = true;
    # Pregenerated Colors to use in Hyprland
    genColorsPath = /home/${users.user1.username}/.cache/hypr/colors.conf;
    animationSpeed = "medium"; # medium or slow
    plugins = {
      Hyprspace = true;
      hyprexpo = false;
      hyprbars = true;
      hyprtrails = true;
      borders-plus-plus = true;
    };
  };

  # ---- Dotfiles Inforamtions ---- #
  dotfilesDir =
    "/home/${users.selected.username}/nixxin"; # Absolute path of the local repo

  # ---------------- #
  # ----- USER ----- #
  # ---------------- #
  users = {
    selected = users.user1;
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
