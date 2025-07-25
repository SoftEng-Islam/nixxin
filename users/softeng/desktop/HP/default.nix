{ pkgs, ... }: rec {
  # ----------------------------------------------
  # ---- The User Information
  # ----------------------------------------------
  # - You must Change all Values here
  user = {
    name = "Islam Ahmed"; # Name/Identifier
    username = "softeng"; # Username
    email = "softeng.islam@gmail.com"; # Email
    devices = {
      desktop = {
        system = {
          hostname = "nixos";
          architecture = "x86_64-linux";
          stateVersion = "24.11";
        };
        home = { };
        language = { };
      };
      laptop = { };
    };
  };
  # ----------------------------------------------
  # ---- System Information And Configuration
  # ----------------------------------------------
  system = {
    name = "nixos";
    hostName = "nixos"; # Hostname
    profile = "desktop"; # Select a profile defined from my profiles directory
    architecture = "x86_64-linux"; # Replace with your system architecture
    stateVersion = "24.11";

    # Change kernel to zen kernal use "pkgs.linuxPackages_zen"
    kernel = pkgs.linuxPackages_zen;

    upgrade = {
      enable = true;
      allowReboot = true;
      # Run `nix-channel --list` to get channels
      channel = "https://channels.nixos.org/nixos-unstable";
    };
  };

  home.stateVersion = "24.11";
  home.backupFileExtension = null;

  # ----------------------------------------------
  # ---- Common Is Shared configs for all Modules.
  # We have this Object because of the..
  # the "xdg defaults" and "env vars" and hyprland keybinding, etc...
  # For Ex: You have BROWSER var, and xdg webBrowser
  # You must set the same Browser the you want as default everywhere.
  # ----------------------------------------------
  common = {
    #* EDITOR Var: used for
    EDITOR = "nvim";
    #* VISUAL Var: used for
    VISUAL = "nvim";
    #* TERM Var: used for
    TERM = "xterm-256color";

    # webBrowser: SET TO "microsoft-edge" OR "google-chrome-stable"
    webBrowser = "google-chrome-stable";

    mainFont.name = "CaskaydiaCove Nerd Font";
    # Typeface made for Developers.
    mainFont.package = pkgs.nerd-fonts.caskaydia-cove;

    # Media Variables:
    videoPlayer = "";
    soundPlayer = "";
    imageViewer = "";

    # [ IDLE ] For Ex: You can set the idle-delay to 300 seconds (5 minutes) or 0 to Disable:
    idle = { delay = 0; };

    # ---- Dotfiles Inforamtions ---- #
    dotfilesDir = "/home/${user.username}/nixxin"; # Absolute path of the repo

    # wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

    # ---- GTK ---- #
    gtk = {
      theme = "adw-gtk3-dark";
      icon_cache = false;
      GTK_THEME = "adw-gtk3-dark"; # Env Variable
      package = pkgs.adw-gtk3;
    };

    # ---------------------
    # ---- Qt
    # ---------------------
    qt = {
      # The options are
      # adwaita, adwaita-dark, adwaita-highcontrast, adawaita-highcontrastinverse: Use Adwaita Qt style with adwaita
      # breeze: Use the Breeze style from breeze
      # bb10bright, bb10dark, cleanlooks, gtk2, motif, plastique: Use styles from qtstyleplugins
      # kvantum: Use styles from kvantum
      style = "adwaita-dark";
      # The options are
      # gnome: Use GNOME theme with qgnomeplatform
      # gtk2: Use GTK theme with qtstyleplugins
      # kde: Use Qt settings from Plasma 5.
      # kde6: Use Qt settings from Plasma 6.
      # lxqt: Use LXQt style set using the lxqt-config-appearance application.
      # qt5ct: Use Qt style set using the qt5ct and qt6ct applications.
      platformTheme = "qt5ct";
      package = pkgs.adwaita-qt;
      QT_QPA_PLATFORMTHEME = "qt5ct";
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
      name = "Bibata-Modern-Classic"; # "Bibata-Modern-Ice" Cursor Name
      package = pkgs.bibata-cursors;
    };
  };

  # ----------------------------------------------
  # ---- Modules
  # ----------------------------------------------
  # Modules: To Enable/Disable && Options.
  # NOTE: The Options doesn't have effect if the module is disabled.
  modules = {
    ai = {
      enable = false;
      ollama = { enable = false; };
    };
    android = {
      enable = true;
      scrcpy = true;
      waydroid = true;
      android_studio = true;
    };
    audio = {
      enable = true;
      rnnoise.enable = true; # Noise Canceling
    };
    bluetooth = { enable = false; };
    browsers = {
      enable = true; # To disable the whole module
      brave = false;
      firefox = false;
      firefox-beta = false;
      google-chrome = true;
      microsoft-edge = false;
    };
    camera = { enable = false; };
    cli_tools = { # Collection of useful CLI apps
      enable = true;

    };
    community = {
      enable = true;
      discord = false;
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
      default = "opencl"; # "pocl" OR "opencl"
    };
    dconf = { enable = true; };
    data_transferring = { # Command-Line/Apps Download Utilities
      enable = true;
      qbittorrent = true;
      aria2 = true;
      axel = false;
      curl = true;
      lux = false;
      wget2 = true;
      yt-dlp = true;
      motrix = false;
      libtorrent-rasterbar = false;
      ariang = true;
      media-downloader = false;
      persepolis = false;
      varia = false;
      deluge = false;
      webtorrent_desktop = false;
      bitmagnet = false;
      transmission = false;
    };
    development = {
      enable = true;
      android = { enable = true; };
      databases = {
        enable = true;
        monogodb = { enable = false; };
        postgresql = { enable = false; };
        mysql = { enable = false; };
        sql = { enable = false; };
      };
      languages = {
        enable = true;
        clang = true;
        dart = { enable = true; };
        go = { enable = true; };
        python = true;
        ruby = false;
        rust = true;
      };
      web = { enable = true; };
      tools = {
        enable = true;
        editors = {
          enable = true;
          zedEditor = false;
          eclipse = false;
          helix = false;
          vscode = {
            enable = true;
            extensions_home = false;
            globalSnippets_home = false;
            userSettings_home = false;
            keybindings_home = false;
          };
          vscodium = false;
          gnomeTextEditor = true;
        };
        # devdocs.enable = false;
        # ide = {
        #   PHPStorm = false;
        #   pyCharm = false;
        # };
      };
      apps = {
        enable = true;
        beekeeper = false;
        dbeaver = false;
        sqlitebrowser = false;
        bruno = false;
        insomnia = false;
      };
    };
    emails = {
      enable = false;
      # thunderbird = true;
    };
    env = { enable = true; };
    file_manager = {
      enable = true;
      spacedrive = true;
    };
    flags = { enable = false; };
    flatpak = { enable = false; };
    fonts = {
      enable = true;
      main = {
        # To Get "Path" of Font Package:
        # nix build nixpkgs#jetbrains-mono --print-out-paths --no-link
        name = "CaskaydiaCove Nerd Font"; # Selected Font
        package = pkgs.nerd-fonts.caskaydia-cove; # Typeface made for developers
        antialiasing = "grayscale";
        hinting = "medium"; # (one of "none", "slight", "medium", "full")
        rendering = "automatic";
        rgba_order = "rgb";

        size = {
          main = 12; # The main font size
          apps = 14;
          desktop = 15;
          popups = 16;
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
    gaming = {
      enable = true; # To support gaming and install gaming stuff
      steam = { enable = false; };
      zeroad = { enable = false; }; # Free game of ancient warfare
      chess = { enable = true; };
    };
    git = { enable = true; };
    graphics = {
      mesa = true;
      enable = true;
      blender = false;
      darktable = false;
      davinci = false;
      drawio = false;
      figmaLinux = false;
      gimp = false;
      inkscape = false;
      lunacy = false;
      kolourpaint = false;
    };
    hacking = { enable = true; };
    home = {
      stateVersion = home.stateVersion;
      backupFileExtension = home.backupFileExtension;
      manual = {
        html = false;
        json = false;
        manpages = false;
      };
    };
    hyprland = {
      enable = true;
      # Pregenerated Colors to use in Hyprland
      genColorsPath = /home/${user.username}/.cache/hypr/colors.conf;
      animationSpeed = "medium"; # medium or slow
      # Enable blur for windows
      blur = { enable = true; };
      opacity = 0.9; # The windows Opacity
      shadow = { enable = true; }; # enable shadow for Hyprland
      rounding = 10; # Rounding Corners for Hyprland Windows
      dim_inactive = true;
      plugins = {
        hyprbars = true;
        hyprspace = true;
        bordersPlus = false;
        hyprexpo = false;
        hyprtrails = false;
      };
      lockscreen = {
        enable = true;
        type = "hyprlock";
        timeOut = 600; # 10min
        font = "";
      };
      hyprpaper = { enable = true; };
    };
    i18n = {
      # ---- Date/Time & Languages ---- #
      timeFormat = 12;
      timezone = "Africa/Cairo"; # Select timezone
      defaultLocale = "en_US.UTF-8"; # Select locale
      mainlanguage = "English"; # Select the main Language.
      languages = [ "arabic" "france" ]; # Add Other Languages
    };
    icons = { enable = true; };
    image_viewer = {
      enable = true;
      eog = true;
      feh = true;
      loupe = true;
    };
    keyboard_remapper = { enable = false; };
    media = {
      enable = true;
      celluloid = true;
      mpv = true;
      vlc = true;
      cava = false;
      codex = true;
      clapper = false;
      glide = false;
      jellyfin = false;
      kdenlive = true;
      shotcut = false;
      music = true;
    };
    networking = {
      enable = true;
      dnsResolver = "systemd-resolved"; # "dnsmasq" or "systemd-resolved"
      nameservers = [ "8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1" ]; # Google's DNS
      dnsmasq = { settings = { server = modules.networks.nameservers; }; };
      networkManager = true;
      wifiBackend = "wpa_supplicant"; # "wpa_supplicant" OR "iwd"
      iwd = false;
      rtl8188eus-aircrack = false;
      waypipe = false;
      rtw = false;
    };
    notifications = { enable = true; };
    office = {
      enable = true;
      siyuan = true;
      evince = true;
      papers = true;
      zathura = true;
      obsidian = true;
      libreoffice = true;
      translators.enable = true;
    };
    overclock = {
      enable = true;
      corectrl.enable = true;
      lactd.enable = true;
    };
    power = {
      enable = true;
      powerManagement = {
        enable = true;
        powertop = true;

        # Often used values: "schedutil", "ondemand", "powersave", "performance"
        cpuFreqGovernor = "performance";
      };
    };
    printing = { enable = false; };
    qt_gtk = { enable = true; };
    recording = {
      enable = true;
      screen = {
        enable = true;
        gpu_recorder = false;
        obs = false;
        wf_recorder = false;
      };
      sound.enable = false;
    };
    remote_desktop = {
      enable = true;
      rdp = { enable = true; };
    };
    resources_monitoring = {
      enable = true;
      resources_app = true;
      btop = {
        enable = true;
        theme = "adapta";
        background = "False";
        rounded = "True";
        update = 1000; # Update time in milliseconds
        temperature = "celsius"; # "celsius", "fahrenheit", "kelvin", "rankine"
        clock = "%I:%M %p";
        # run to get Network Interface Name: ip addr show
        net_iface = "wlp0s19f2u5";
      };
    };
    screenshot = {
      enable = true;
      flameshot = true;
      slurp = true;
    };
    security = {
      enable = true;
      tpm2 = false;
    };
    sound_editor = {
      enable = true;
      audacity = false;
    };
    ssh = { enable = false; };
    storage = {
      enable = true;
      fstrim.enable = true;
      beesd = { enable = false; };
    };
    styles = {
      enable = false;
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
            size = 4;
          };
          inactive = {
            color = "#ddd8";
            size = 4;
          };
        };
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
    };
    system = {
      # Whether to enable ROCM, Make Sure that your APU/GPU Supported before Enable it
      rocm = { enable = false; };
      radeon = false;
      boot = {
        tmp.useTmpfs = true;
        loader = {
          timeout = 3; # seconds
          mode = "UEFI"; # UEFI OR BIOS
          manager = {
            # Select The boot manager to enable
            name = "GRUB"; # "GRUB" or "SYSTEMD"

            # device identifier for grub; only used for legacy (bios) boot mode
            # List all the devices with their by-id symlinks
            # ls -l /dev/disk/by-id/
            grub = {
              fontSize = 14;
              # nix path-info -r nixpkgs#sleek-grub-theme
              theme = with pkgs;
                (sleek-grub-theme.override {
                  withStyle = "dark"; # (dark/light/orange/bigsur)
                  withBanner = "GRUB Boot Manager";
                });
              osProber = true;
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
        kernelParams = [
          "usbcore.autosuspend=-1" # disable usb autosuspend
          "usbhid.mousepoll=4" # Reduce USB mouse polling rate
          #"xhci_hcd.quirks=0x40" # USB3.0?g

          # This disables specific USB ports at boot time.
          # "usb-port.port_disable=1-11" # -.-

          # AMD GPU optimizations
          # The oldest architectures that AMDGPU supports are Southern Islands (SI, i.e. GCN 1) and Sea Islands (CIK, i.e. GCN 2), but support for them is disabled by default. To use AMDGPU instead of the radeon driver, you can set the kernel parameters:
          # for Southern Islands (SI i.e. GCN 1) cards
          "radeon.si_support=0" # Ensures Radeon drivers don’t interfere
          "amdgpu.si_support=1"

          # for Sea Islands (CIK i.e. GCN 2) cards
          "radeon.cik_support=0"
          "amdgpu.cik_support=1"

          # Disables AMD's IOMMU (Input-Output Memory Management Unit).
          # May improve compatibility or performance, especially on systems where IOMMU causes issues (like hangs or USB problems).
          # ⚠️ Not suitable if you use VFIO, PCI passthrough, or some types of sandboxing.
          "amd_iommu=off"

          # Sets the number of hardware job queues (rings) that the AMD GPU scheduler can submit in parallel.
          "amdgpu.sched_hw_submission=4"

          # ttm stands for Translation Table Maps — a core part of the GPU memory manager in the Linux kernel used by TTM-based drivers, like AMDGPU.
          # pages_min sets the minimum number of memory pages reserved for the GPU.
          # Each page is 4 KiB, so:
          # (1048576*4096) / 1073741824 = 4 GiB
          # (2097152*4096) / 1073741824 = 8 GiB
          # 1048576 pages = 4 GiB
          # 2097152 pages = 8 GiB
          # You can increase this value to 2097152 (8 GiB) if you want to reserve more memory.
          "ttm.pages_min=1048576"

          # Disables the Linux audit subsystem.
          # Reduces kernel log noise and slightly improves performance, especially on systems that don’t need SELinux/AppArmor audit trails.
          "audit=0"

          # If you want full control over power settings, use:
          "amdgpu.ppfeaturemask=0xffffffff" # Unlock all gpu controls
          # If you have stability issues (freezes, black screens, crashes), try:
          # "amdgpu.ppfeaturemask=0xFFF7FFFF"
          # Check If It’s Applied:
          # cat /sys/module/amdgpu/parameters/ppfeaturemask
          # "amdgpu.dcfeaturemask=0x8"

          "amdgpu.dc=1" # Enables Display Core (improves multi-display support)
          "amdgpu.gpu_recovery=1" # Auto-recover from GPU hangs (safe)
          "amdgpu.debugmask=1" # Enables some debugging logs

          # Disables HDMI/DisplayPort audio output on AMD GPUs.
          # Useful if you're not using HDMI/DP audio and want to prevent driver conflicts.
          "amdgpu.audio=0"

          # Enables Dynamic Power Management (DPM). Allows the GPU to adjust its clock and voltage for power saving and performance.
          "amdgpu.dpm=1"

          # Disables runtime power management. Helps keep the GPU always powered on (useful for debugging or fixing suspend/resume issues).
          "amdgpu.runpm=0"

          # Enables FreeSync support in video playback (if supported).
          # "amdgpu.freesync_video=1"

          # Enables 10-bit or 12-bit deep color support (if monitor supports it).
          # "amdgpu.deep_color=1"

          # Limits visible VRAM to 4096 MB (4 GB). Can help with compatibility on buggy BIOSes or old systems.
          "amdgpu.vramlimit=4096"

          # Sets the GTT (Graphics Translation Table) memory size in MB. This is memory used when VRAM runs out (from system RAM).
          "amdgpu.gttsize=4096"

          # Enables unified memory model between GPU and CPU. Can improve memory sharing on APU systems.
          "amdgpu.unified_memory=1"

          # Controls how memory is allocated:
          # 0: Prefer VRAM
          # 1: Even balance
          # 2: Prefer GTT (shared RAM)
          # 💡 Use 2 for APUs with little VRAM.
          "amdgpu.memory_alloc_mode=2"

          # Sets the virtual address space size in GB.
          # 🚀 Increasing can help with large OpenCL/Vulkan workloads.
          "amdgpu.vm_size=8"

          # Sets page fragment size (2⁹ = 512 KiB) for GPU virtual memory.
          # Larger values = fewer page table entries = better perf on large buffers.
          # Set -1 to let driver decide automatically.
          # "amdgpu.vm_fragment_size=-1"

          # Set amdgpu.lockup_timeout in order to control the TDR for each ring
          # 0 (GFX): 5s (was 10s)
          # 1 (Compute): 10s (was 60s wtf)
          # 2 (SDMA): 10s (was 10s)
          # 3 (Video): 5s (was 10s)
          "amdgpu.lockup_timeout=5000,10000,10000,5000"

          "amdgpu.noretry=0" # Improve memory handling
        ];
        kernelModules = [
          # "amd-pstate"
          # "zenpower"
          "amdgpu"
          "radeon"
          "binder_linux"
          "usbhid"
          "usbcore"
          "8188eu"
          "bfq"
          "coretemp"
          "fuse"
          "kvm-amd"
          "msr"
          "uinput"
          "v4l2loopback"
        ];
        extraModprobeConfig = ''
          options usbcore autosuspend=-1
          options binder_linux devices=binder,hwbinder,vndbinder
        '';
        initrd = { kernelModules = [ "amdgpu" "radeon" ]; };
      };
      amdgpu = {
        initrd = true;
        opencl = false;
        legacySupport = false;
        amdvlk = true;
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

    };
    terminals = {
      enable = true;
      default = {
        shell = "zsh"; # bash
        font = {
          # family = "CaskaydiaCove Nerd Font"; # or "JetBrains Nerd Font"
          family = "FiraCode Nerd Font";
          bold = "FiraCode Nerd Font Bold";
          italic = "FiraCode Nerd Font Italic";
          bold_italic = "FiraCode Nerd Font Bold Italic";
          size = 14;
          package = pkgs.nerd-fonts.fira-code;
        };
        # Default Terminal That will Appear when you click Super+T
        terminal = {
          name = "wezterm"; # To Run Press: Super + T
          package = pkgs.wezterm;
        };
      };
      kitty = {
        shell = modules.terminals.default.shell;
        fontFamily = modules.terminals.default.font.family;
        fontBold = modules.terminals.default.font.bold;
        fontItalic = modules.terminals.default.font.italic;
        fontBoldItalic = modules.terminals.default.font.bold_italic;
        fontSize = modules.terminals.default.font.size;
      };
      alacritty = {
        shell = modules.terminals.default.shell;
        fontFamily = modules.terminals.default.font.family;
        fontSize = modules.terminals.default.font.size;
      };
      foot = {
        shell = modules.terminals.default.shell;
        fontFamily = modules.terminals.default.font.family;
        fontSize = modules.terminals.default.font.size;
      };
      wezterm = {
        shell = modules.terminals.default.shell;
        fontFamily = modules.terminals.default.font.family;
        fontSize = modules.terminals.default.font.size;
        colorScheme = "Apple System Colors";
      };
      fish = {
        shell = modules.terminals.default.shell;
        fontFamily = modules.terminals.default.font.family;
        fontSize = modules.terminals.default.font.size;
      };
    };
    tools = { enable = false; };
    ulauncher.enable = true;
    users = { name = user.name; };
    virtualization = { enable = true; };
    wayland = { enable = true; };
    windows = {
      enable = true;
      wine = { enable = true; };
    };
    xdg = {
      enable = true;
      # Select Your Default Apps:
      defaults = {
        #! [NOTICE]:
        #! - Make Sure you have install/enable the apps to use as default.
        #! - Write The name of apps without ".desktop" like:
        #! - - [ "microsoft-edge" ] , Not [ "microsoft-edge.desktop" ]

        # find /nix/store/ -name "*edge*.desktop"
        # or
        # fd -g '*edge*.desktop' /nix/store/

        # Default Web Browser, Ex:
        # - "microsoft-edge"
        # - "brave-browser"
        # - "google-chrome"
        webBrowser = "google-chrome";

        # Default Images Viewer, Ex:
        # - "org.gnome.Loupe"
        # - "feh"
        imageViewer = "org.gnome.Loupe";

        # Default Videos Player, Ex:
        # - "mpv"
        # - "io.github.celluloid_player.Celluloid"
        # - "vlc"
        videoPlayer = "mpv";

        # Default Audio Player:
        # - "mpv"
        # - "io.bassi.Amberol"
        audioPlayer = "mpv";

        # Default File Manager, Ex:
        # - "org.gnome.Nautilus"
        # - "thunar"
        fileManager = "org.gnome.Nautilus";

        # Default Programming Code Editor, Ex:
        # - "code"
        editor = "code";

        # Default Torrent App, Ex:
        # - "org.qbittorrent.qBittorrent"
        # - "deluge"
        torrentApp = "org.qbittorrent.qBittorrent";

        # Default .exe runner, Ex:
        # - "wine"
        windowsExeFileRunner = "wine";
      };
    };
    zram = {
      enable = true;
      algorithm = "lz4"; # "lz4", "zstd"
    };
  };
}
