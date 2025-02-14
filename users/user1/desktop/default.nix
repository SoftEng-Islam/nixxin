{ pkgs, ... }: rec {
  user1 = import (./. + "../user.nix");
  # ----------------------------------------------
  # ---- System Information And Configuration
  # ----------------------------------------------
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
  };

  home.stateVersion = "24.11";
  home.backupFileExtension = null;

  global = {
    # ---- Lockscreen ---- #
    lockscreen = {
      enable = true;
      type = "hyprlock";
      timeOut = 600; # 10min
      name = "";
      package = "";
      font = "";
    };

    # ---- IDLE ---- #
    # For Ex: You can set the idle-delay to 300 seconds (5 minutes) or
    # 0 to Disable:
    idle = { delay = 0; };

    # wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

    # ---- Dotfiles Inforamtions ---- #
    dotfilesDir = "/home/${user1.username}/nixxin"; # Absolute path of the repo
  };

  # ----------------------------------------------
  # ---- Hardware
  # ----------------------------------------------
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

    # Video Drivers (based on GPU vendor)
    videoDrivers = if hardware.gpu.vendor == "amd" then
      [ "amdgpu" ] # Default driver for AMD GPUs
    else if hardware.gpu.vendor == "nvidia" then
      [ "nvidia" ] # Default driver for NVIDIA GPUs
    else if hardware.gpu.vendor == "intel" then
      [ "modesetting" ] # Default driver for Intel GPUs
    else
      [ "modesetting" ]; # Fallback driver
  };

  # ----------------------------------------------
  # ---- Modules
  # ----------------------------------------------
  # Modules: To Enable/disable && Options.
  # NOTE: The Options doesn't have effect if the module is disabled.
  modules = {
    ai = {
      enable = false;
      ollama = { enable = true; };
    };
    android = {
      enable = true;
      scrcpy = true;
      waydroid = true;
      development = true;
      android_studio = false;
    };
    audio = {
      enable = true;
      rnnoise.enable = true; # Noise Canceling
    };
    bluetooth = { enable = false; };
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
    browsers = { # Browsers To Install
      enable = true;
      brave = true;
      firefox = false;
      firefox-beta = false;
      google-chrome = true;
      microsoft-edge = true;
    };
    cli = { # Collection of useful CLI apps
      enable = true;
    };
    community = {
      enable = true;
      discord = true;
      ferdium = true;
      mumble = false;
      revolt = false;
      signal = false;
      slack = false;
      telegram = true;
      vesktop = false;
      zoom = false;
    };
    computing = {
      enable = true;
      default = "pocl"; # "pocl" OR "opencl"
    };
    data_transferring = { # Command-Line/Apps Download Utilities
      enable = true;
      qbittorrent = true;
      aria2 = true;
      axel = false;
      curl = true;
      lux = true;
      wget2 = true;
      yt-dlp = true;
      motrix = false;
      libtorrent-rasterbar = true;
      ariang = true;
      media-downloader = false;
      persepolis = false;
      varia = false;
    };
    development = {
      enable = true;
      databases = {
        enable = true;
        monogodb = true;
        MySQL = true;
        sql = true;
      };
      languages = { enable = true; };
      tools = {
        enable = true;
        devdocs = true;
        ide = {
          PHPStorm = false;
          pyCharm = false;
        };
      };
      apps = {
        beekeeper = true;
        dbeaver = true;
        sqlitebrowser = true;
        bruno = true;
        insomnia = true;
      };
    };
    display_manager = { # Display/Login manager
      enable = true;
      default = "gdm"; # gdm OR greetd OR tuigreet OR sddm
      defaultSession = "hyprland"; # hyprland or hyprland-uwsm or gnome
    };
    docs = {
      enable = true;
      doc.enable = true;
      man = {
        enable = true;
        generateCaches = false;
      };
      dev.enable = true;
      info.enable = true;
      nixos.enable = true;
    };
    documents = { };
    drivers = { };
    editors = { };
    emails = { };
    file_manager = { };
    flags = { };
    gaming = {
      enable = true; # To support gaming and install gaming stuff
      steam = { enable = false; };
      # Free, open-source game of ancient warfare
      zeroad = { enable = false; };
    };
    git = { };
    graphics = {
      enable = true;
      blender = true;
      darktable = false;
      davinci = true;
      drawio = true;
      figmaLinux = false;
      gimp = true;
      inkscape = true;
      lunacy = true;
    };
    hacking = { };
    hardware = { };
    home = {
      stateVersion = home.stateVersion;
      backupFileExtension = home.backupFileExtension;
    };
    i18n = {
      # ---- Date/Time & Languages ---- #
      timeFormat = 12;
      timezone = "Africa/Cairo"; # Select timezone
      defaultLocale = "en_US.UTF-8"; # Select locale
      mainlanguage = "English"; # Select the main Language.
      languages = [ "arabic" "france" ]; # Add Other Languages
    };
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
          apps = 16;
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
    };
    image_viewer = { };
    keyboard_remapper = { };
    media = { };
    network = {
      dnsResolver = "dnsmasq"; # dnsmasq or systemd-resolved
      ethernet = "eno1";
      wlanInterface = "wlp0s19f2u5";
      nameservers = [ "8.8.8.8" "8.8.4.4" ]; # Google's DNS
      dnsmasq = { settings = { server = modules.networks.nameservers; }; };
    };
    nh = { };
    nix = { };
    notifications = { };
    overclock = { corectrl = { enable = true; }; };
    power = { };
    qt_gtk = { };
    recording = { };
    resources_monitoring = {
      btop = {
        enable = true;
        timeFormat = "12"; # or 24
      };
    };
    screenshot = { };
    security = { };
    services = { };
    ssh = { };
    storage = {
      enable = true;
      fstrim.enable = true;
    };
    styles = {
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
            color = modules.styles.mainColor;
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
        platformTheme =
          "qt5ct"; # (one of "gnome", "gtk2", "kde", "lxqt", "qtct")
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
    systemd = { };
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
        shell = modules.terminals.default.shell;
        family = modules.terminals.default.font.family;
        size = modules.terminals.default.font.size;
        bold = modules.terminals.default.font.bold;
        italic = modules.terminals.default.font.italic;
        bold_italic = modules.terminals.default.font.bold_italic;
      };
      alacritty = {
        shell = modules.terminals.default.shell;
        family = modules.terminals.default.font.family;
        size = modules.terminals.default.font.size;
      };
      foot = {
        shell = modules.terminals.default.shell;
        family = modules.terminals.default.font.family;
        size = modules.terminals.default.font.size;
      };
      wezterm = {
        shell = modules.terminals.default.shell;
        family = modules.terminals.default.font.family;
        size = modules.terminals.default.font.size;
      };
      fish = {
        shell = modules.terminals.default.shell;
        family = modules.terminals.default.font.family;
        size = modules.terminals.default.font.size;
      };
    };
    virtualization = { };
    wayland = { };
    windows = { wine = { enable = true; }; };
    window_manager = {
      # ---- Hyprland ---- #
      hyprland = {
        enable = true;
        # Pregenerated Colors to use in Hyprland
        genColorsPath = /home/${user1.username}/.cache/hypr/colors.conf;
        animationSpeed = "medium"; # medium or slow
        plugins = {
          hyprbars = true;
          hyprspace = true;
          bordersPlus = false;
          hyprexpo = false;
          hyprtrails = false;
        };
      };
    };
    write_shell = { };
    xdg = {
      enable = true;
      defaults = {
        fileManager = "nautilus"; # thunar & nautilus
        imageViewer = "loupe"; # feh or loupe
        videoPlayer = "celluloid"; # vlc or celluloid or mpv
        torrentApp = "qBittorrent";
      };
    };
    zram = {
      enable = true;
      algorithm = "lz4"; # lz4 or zstd
    };
  };
}
