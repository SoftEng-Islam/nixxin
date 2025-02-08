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

    # Features: To Install Extra Packages and file systems & apps
    features = {
      android = {
        development_stuff = true;
        android_studio = false;
      };
      btop = {
        enable = true;
        timeFormat = "12"; # or 24
      };
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
      inkscape = true;
      darktable = true;
    };
    editors = {
      vscode = true;
      zedEditor = true;
      vscodium = true;
      gnomeTextEditor = true;
      eclipse = true;
      helix = true;
    };
    fileManagers = {
      spacedrive = true;
      nautilus = true;
      thunar = false;
      nemo = true;
    };
  };

  # -------------- #
  # ---- HOME ---- #
  # -------------- #
  home = {
    stateVersion = "24.11";
    backupFileExtension = null;
  };

  # ----------------- #
  # ---- DESKTOP ---- #
  # ----------------- #
  desktop = {
    # ---- Lockscreen ---- #
    lockscreen = {
      enable = true;
      name = "";
      package = "";
      font = "";
    };
    # ---- IDLE ---- #
    # For Ex: You can set the idle-delay to 300 seconds (5 minutes) or
    # 0 to Disable:
    idle = { delay = 0; };
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
    enable = true;
    type = "hyprlock";
    timeOut = 600; # 10min
  };

  # -------------- #
  # ---- Boot ---- #
  # -------------- #
  boot = {
    loader = {
      timeout = 3; # seconds
      mode = "UEFI"; # UEFI OR BIOS
      manager = {
        # Select The boot manager to enable
        name = "GRUB"; # GRUB or SYSTEMD

        # device identifier for grub; only used for legacy (bios) boot mode
        # List all the devices with their by-id symlinks
        # ls -l /dev/disk/by-id/
        grub = {
          fontSize = 18;
          # nix path-info -r nixpkgs#sleek-grub-theme
          theme = "${pkgs.sleek-grub-theme}/grub/themes/sleek";
          osProber = false;
          efiSupport = true;
          gfxmodeEfi = "1920x1080";
          devices = [ "nodev" ];
          device = "nodev"; # Let GRUB automatically detect EFI
          extraConfig = ''
            GRUB_DISABLE_OS_PROBER=true
            GRUB_CMDLINE_LINUX="root=UUID=ba8daecb-c5d6-4dc9-bc51-a38b344ca6ed rootflags=subvol=@"
          '';
        };
      };
    };
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
  networks = {
    dnsResolver = "dnsmasq"; # dnsmasq or systemd-resolved
  };
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
  defaultSession = "hyprland"; # hyprland  or hyprland-uwsm or gnome
  wm = [ "hyprland" ]; # Selected window manager or desktop environment;
  wmType =
    if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

  # ---- Hyprland ---- #
  hyprland = {
    enable = true;
    # Pregenerated Colors to use in Hyprland
    genColorsPath = /home/${users.selected.username}/.cache/hypr/colors.conf;
    animationSpeed = "medium"; # medium or slow
    plugins = {
      hyprbars = true;
      hyprspace = true;
      bordersPlus = false;
      hyprexpo = false;
      hyprtrails = false;
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

  # ------------------- #
  # ---- Terminals ---- #
  # ------------------- #
  terminals = {
    default = {
      shell = "zsh"; # bash
      font = {
        family = "CaskaydiaCove Nerd Font";
        bold = "CaskaydiaCove Nerd Font Bold";
        italic = "CaskaydiaCove Nerd Font Italic";
        bold_italic = "CaskaydiaCove Nerd Font Bold Italic";
        size = 14;
        package = pkgs.nerd-fonts.caskaydia-cove;
      };
      term = {
        name = "kitty"; # Default terminal command
        package = pkgs.kitty;
      };
    };
    kitty = {
      shell = terminals.default.shell;
      family = terminals.default.font.family;
      size = terminals.default.font.size;
      bold = terminals.default.font.bold;
      italic = terminals.default.font.italic;
      bold_italic = terminals.default.font.bold_italic;
    };
    alacritty = {
      shell = terminals.default.shell;
      family = terminals.default.font.family;
      size = terminals.default.font.size;
    };
    foot = {
      shell = terminals.default.shell;
      family = terminals.default.font.family;
      size = terminals.default.font.size;
    };
    wezterm = {
      shell = terminals.default.shell;
      family = terminals.default.font.family;
      size = terminals.default.font.size;
    };
    fish = {
      shell = terminals.default.shell;
      family = terminals.default.font.family;
      size = terminals.default.font.size;
    };
  };

  term = "kitty";
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
      # nix build nixpkgs#jetbrains-mono --print-out-paths --no-link
      # to get path of package
      # nix path-info -r nixpkgs#jetbrains-mono
      # "JetBrainsMonoNL Font Mono"
      # "JetBrainsMonoNL Font Bold"
      # "CaskaydiaCove Nerd Font"
      name = "CaskaydiaCove Nerd Font"; # Selected Font
      package = pkgs.nerd-fonts.caskaydia-cove; # Typeface made for developers
      antialiasing = "grayscale";
      hinting = "medium"; # (one of "none", "slight", "medium", "full")
      rendering = "automatic";
      rgba_order = "rgb";

      size = {
        main = 14; # Font size
        applications = 16;
        desktop = 18;
        popups = 18;
      };
    };
    monospace = {
      name = "CaskaydiaCove Nerd Font Mono";
      package = pkgs.nerd-fonts.caskaydia-mono;
    };
    serif = {
      name = "CaskaydiaCove Nerd Font";
      package = pkgs.nerd-fonts.caskaydia-cove;
    };
    sansSerif = {
      name = "CaskaydiaCove Nerd Font";
      package = pkgs.nerd-fonts.caskaydia-cove;
    };
    hyprbars = {
      name = "CaskaydiaCove Nerd Font Bold";
      size = 11;
    };
    terminals = {
      kitty = {
        name = "CaskaydiaCove Nerd Font";
        bold_font = "CaskaydiaCove Nerd Font Bold";
        italic_font = "CaskaydiaCove Nerd Font Italic";
        bold_italic_font = "CaskaydiaCove Nerd Font Bold Italic";
        size = 14;
      };
      alacritty = {
        name = "CaskaydiaCove Nerd Font";
        size = 15;
      };
      foot = {
        name = "CaskaydiaCove Nerd Font";
        size = 15;
      };
      wezterm = {
        name = "CaskaydiaCove Nerd Font";
        size = 15;
      };
      fish = {
        name = "CaskaydiaCove Nerd Font";
        size = 15;
      };
    };
  };

  # ---------------- #
  # ---- Styles ---- #
  # ---------------- #
  style = {
    name = "nixxin";

    # Blue, Teal, Green, Yellow, Orange, Red, Pink, Purple, Slate
    mainColor = {
      name = "red";
      hash = "B91C1C";
    };

    # ---- Mode ---- #
    mode = "dark"; # "dark" or "light"
    colorScheme = "prefer-dark";

    # ---- Window Properties ---- #
    window = {
      opacity = 0.9; # The windows Opacity
      blur = true; # Enable blur for windows
      shadow = true; # enable shadow for Hyprland
      rounding = 10; # rounding corners for Hyprland windwos
      dim_inactive = true;
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
    };
    # ---- GTK ---- #
    gtk = {
      # Material
      # adw-gtk3-dark
      theme = "Material";
      package = pkgs.adw-gtk3;
      icon_cache = false;
    };
    # ---- Qt ---- #
    qt = {
      style = "adwaita-dark";
      platformTheme = "qt5ct"; # (one of "gnome", "gtk2", "kde", "lxqt", "qtct")
      package = pkgs.kdePackages.breeze;
      SCALE_FACTOR = 1;
    };
    # ---- Icons ---- #
    icons = {
      nameInLight = "Papirus";
      nameInDark = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;

      # ---- File Manager Icons Size ---- #
      # "small" or "small-plus" or "medium" or "large" or "extra-large"
      icon_view_size = "large"; # Set icon size for nautilus file manager.
    };
    # ---- Cursor ---- #
    cursor = {
      # 16, 32, 48 or 64
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
    steam = { enable = false; };
    # Free, open-source game of ancient warfare
    zeroad = { enable = false; };
  };
}
