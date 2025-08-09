# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }: rec {
  # ----------------------------------------------
  # ---- The User Information
  # ----------------------------------------------
  # - You must Change all Values here
  user.name = "Islam Ahmed"; # Name/Identifier
  user.username = "softeng"; # Username
  user.email = "softeng.islam@gmail.com"; # Email

  # ----------------------------------------------
  # ---- System Information And Configuration
  # ----------------------------------------------
  system.name = "nixos";
  system.hostName = "nixos"; # Hostname
  system.profile =
    "desktop"; # Select a profile defined from my profiles directory
  system.architecture = "x86_64-linux"; # Replace with your system architecture

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Change kernel to zen kernal use "pkgs.linuxPackages_zen"
  system.kernel = pkgs.linuxPackages_zen;
  useTmpfs = false; # disable it before install a custom Linux Kernel.
  system.upgrade.enable = false;
  system.upgrade.allowReboot = false;
  # Run `nix-channel --list` to get channels
  system.upgrade.channel = "https://channels.nixos.org/nixos-unstable";

  # ----------------------------------------------
  # ---- Home-Manager Information And Configuration
  # ----------------------------------------------
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # ! Please read the comment before changing.
  home.backupFileExtension = null;
  home.manual.html = false;
  home.manual.json = false;
  home.manual.manpages = false;

  # ----------------------------------------------
  # ---- Common Is Shared configs for all Modules.
  # We have this Object because of the..
  # the "xdg defaults" and "env vars" and hyprland keybinding, etc...
  # For Ex: You have BROWSER var, and xdg webBrowser
  # You must set the same Browser the you want as default everywhere.
  # ----------------------------------------------
  common.EDITOR = "nvim"; # ? EDITOR Var: used for
  common.VISUAL = "nvim"; # ? VISUAL Var: used for
  common.TERM = "xterm-256color"; # ? TERM Var: used for
  common.webBrowser = "google-chrome-stable";
  common.mainFont.name = "CaskaydiaCove Nerd Font";
  common.mainFont.package = pkgs.nerd-fonts.caskaydia-cove;
  # [ Media ] Variables:
  common.videoPlayer = "";
  common.soundPlayer = "";
  common.imageViewer = "";
  # [ IDLE ] For Ex: You can set the idle-delay to 300 seconds (5 minutes) or 0 to Disable:
  common.idle = { delay = 0; };
  # [ Dotfiles ] Inforamtions ---- #
  common.dotfilesDir =
    "/home/${user.username}/nixxin"; # Absolute path of the repo
  # common.wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
  # [ GTK ]
  common.gtk.theme = "adw-gtk3-dark";
  common.gtk.icon_cache = false;
  common.gtk.GTK_THEME = "adw-gtk3-dark"; # Env Variable
  common.gtk.package = pkgs.adw-gtk3;
  # [ QT ]
  common.qt.style = "adwaita-dark";
  common.qt.platformTheme = "qt5ct";
  common.qt.package = pkgs.adwaita-qt;
  common.qt.QT_QPA_PLATFORMTHEME = "qt5ct";
  common.qt.SCALE_FACTOR = 1;
  # [ ICONS ]
  common.icons.nameInLight = "Papirus";
  common.icons.nameInDark = "Papirus-Dark";
  common.icons.package = pkgs.papirus-icon-theme;
  # [ CURSOR ]
  common.cursor.size = 24; # 16, 32, 48 or 64 Cursor Size
  common.cursor.name =
    "Bibata-Modern-Classic"; # "Bibata-Modern-Ice" Cursor Name
  common.cursor.package = pkgs.bibata-cursors;

  # This environment variable is used to set a custom directory for scripts that will be
  # executed by the user (command line/hyprland keybinding). It is often used to store personal scripts or utilities
  # that you want to run from the command line without specifying the full path.
  scriptsDir = "/home/${user.username}/scripts";

  # ----------------------------------------------
  # ---- Modules To [ Enable/Disable ]
  # ----------------------------------------------
  # Modules: To Enable/Disable.
  # NOTE: The Options doesn't have effect if the module is disabled.
  # Set true to Enable, and false to Disable.
  modules.pkgs.enable = true;
  modules.system.enable = true;
  modules.security.enable = true;
  modules.graphics.enable = true;
  modules.fonts.enable = true;
  modules.development.enable = true;
  modules.cli_tools.enable = true;
  modules.ulauncher.enable = true;
  modules.computing.enable = true;
  modules.browsers.enable = true;
  modules.storage.enable = true;
  modules.users.enable = true;
  modules.data_transferring.enable = true;
  modules.hacking.enable = true;
  modules.dconf.enable = true;
  modules.env.enable = true;
  modules.desktop.enable = true;
  modules.media.enable = true;
  modules.git.enable = true;
  modules.i18n.enable = true;
  modules.networking.enable = true;
  modules.power.enable = true;
  modules.overclock.enable = true;
  modules.office.enable = true;
  modules.icons.enable = true;
  modules.virtualization.enable = true;
  modules.zram.enable = false;
  modules.ssh.enable = false;
  modules.ai.enable = false;
  modules.emails.enable = true;
  modules.flatpak.enable = false;
  modules.notifications.enable = true;
  modules.printing.enable = false;
  modules.android.enable = true;
  modules.camera.enable = false;
  modules.recording.enable = true;
  modules.sound_editor.enable = true;
  modules.windows.enable = true;
  modules.audio.enable = true;
  modules.gaming.enable = true;
  modules.remote_desktop.enable = true;
  modules.bluetooth.enable = false;
  modules.community.enable = true;

  # ----------------------------------------------
  # ---- Modules Configuration (Options)
  # ----------------------------------------------
  # [ AI ]
  modules.ai.ollama.enable = false;

  # [ android ]
  modules.android.scrcpy.enable = true;
  modules.android.waydroid.enable = true;
  modules.android.android_studio.enable = false;

  # [Audio]
  modules.audio.rnnoise.enable = true; # Noise Canceling

  # [ Browsers ]
  modules.browsers.google-chrome.enable = true;
  modules.browsers.brave.enable = false;
  modules.browsers.firefox.enable = false;
  modules.browsers.firefox-beta.enable = false;
  modules.browsers.microsoft-edge.enable = true;

  # [ cli_tools ] Collection of useful CLI apps/terminals/shells
  modules.cli_tools.prompt.enable = true;
  modules.cli_tools.shells.enable = true;
  modules.cli_tools.terminals.enable = true;
  modules.cli_tools.utilities.enable = true;
  modules.cli_tools.utilities.bat.enable = true;
  modules.cli_tools.utilities.direnv.enable = false;
  modules.cli_tools.utilities.emacs.enable = true;

  # [ Community ]
  modules.community.telegram.enable = true;
  modules.community.ferdium.enable = false;
  modules.community.discord.enable = false;
  modules.community.mumble.enable = false;
  modules.community.revolt.enable = false;
  modules.community.signal.enable = false;
  modules.community.slack.enable = false;
  modules.community.vesktop.enable = false;
  modules.community.zoom.enable = false;

  # [ Computing ]
  modules.computing.default = "opencl"; # "pocl" OR "opencl"

  # [ data_transferring ] Command-Line/Apps Download Utilities
  modules.data_transferring.curl.enable = true;
  modules.data_transferring.wget2.enable = true;
  modules.data_transferring.aria2.enable = true;
  modules.data_transferring.yt-dlp.enable = true;
  modules.data_transferring.qbittorrent.enable = true;
  modules.data_transferring.axel.enable = false;
  modules.data_transferring.lux.enable = false;
  modules.data_transferring.motrix.enable = false;
  modules.data_transferring.libtorrent-rasterbar.enable = false;
  modules.data_transferring.ariang.enable = true;
  modules.data_transferring.media-downloader.enable = false;
  modules.data_transferring.persepolis.enable = false;
  modules.data_transferring.varia.enable = false;
  modules.data_transferring.deluge.enable = false;
  modules.data_transferring.webtorrent_desktop.enable = false;
  modules.data_transferring.bitmagnet.enable = false;
  modules.data_transferring.transmission.enable = false;

  # [ development ]
  modules.development.android.enable = false;
  # [ development ] [ databases ]
  modules.development.databases.enable = false;
  modules.development.databases.monogodb = { enable = false; };
  modules.development.databases.postgresql = { enable = false; };
  modules.development.databases.mysql = { enable = false; };
  modules.development.databases.sql = { enable = false; };
  # [ development ] [ languages ]
  modules.development.languages.enable = false;
  modules.development.languages.clang = false;
  modules.development.languages.dart.enable = false;
  modules.development.languages.go.enable = false;
  modules.development.languages.python = false;
  modules.development.languages.ruby = false;
  modules.development.languages.rust = false;
  # [ development ] [ web ]
  modules.development.web.enable = false;
  # [ development ] [ apps ]
  modules.development.apps.enable = true;
  modules.development.apps.beekeeper = false;
  modules.development.apps.dbeaver = true;
  modules.development.apps.sqlitebrowser = true;
  modules.development.apps.bruno = true;
  modules.development.apps.insomnia = true;
  # [ development ] [ tools ]
  modules.development.tools.enable = true;
  modules.development.tools.devdocs.enable = false;
  modules.development.tools.editors.enable = true;
  modules.development.tools.editors.zedEditor = true;
  modules.development.tools.editors.eclipse = false;
  modules.development.tools.editors.helix = true;
  modules.development.tools.editors.vscodium = false;
  modules.development.tools.editors.gnomeTextEditor = true;
  modules.development.tools.editors.vscode = {
    enable = true;
    extensions_home = false;
    globalSnippets_home = false;
    userSettings_home = false;
    keybindings_home = false;
  };

  # [ desktop ]
  modules.desktop.tools = false;

  # [Emails]
  modules.emails.thunderbird = true;

  # [file_manager]
  modules.file_manager.spacedrive = true;

  # [fonts]
  modules.fonts = {
    # To Get "Path" of Font Package:
    # nix build nixpkgs#jetbrains-mono --print-out-paths --no-link
    main.name = "CaskaydiaCove Nerd Font"; # Selected Font
    main.package =
      pkgs.nerd-fonts.caskaydia-cove; # Typeface made for developers
    main.antialiasing = "grayscale";
    main.hinting = "medium"; # (one of "none", "slight", "medium", "full")
    main.rendering = "automatic";
    main.rgba_order = "rgb";
    main.size.main = 12; # The main font size
    main.size.apps = 14;
    main.size.desktop = 15;
    main.size.popups = 16;
    monospace.name = "CaskaydiaCove Nerd Font Mono";
    monospace.package = pkgs.nerd-fonts.caskaydia-mono;
    serif.name = "CaskaydiaCove Nerd Font";
    serif.package = pkgs.nerd-fonts.caskaydia-cove;
    sansSerif.name = "CaskaydiaCove Nerd Font";
    sansSerif.package = pkgs.nerd-fonts.caskaydia-cove;
    hyprbars.name = "CaskaydiaCove Nerd Font Bold";
    hyprbars.size = 11;
  };

  # [gaming]
  modules.gaming.steam.enable = false;
  modules.gaming.zeroad.enable = true; # Free game of ancient warfare
  modules.gaming.chess.enable = true;

  # [ Graphics ]
  modules.graphics.mesa = true;
  modules.graphics.blender = true;
  modules.graphics.darktable = false;
  modules.graphics.davinci = false;
  modules.graphics.drawio = false;
  modules.graphics.figmaLinux = false;
  modules.graphics.gimp = false;
  modules.graphics.inkscape = false;
  modules.graphics.lunacy = true;
  modules.graphics.kolourpaint = false;

  # [ Hyprland ]
  modules.desktop.hyprland.genColorsPath =
    /home/${user.username}/.cache/hypr/colors.conf;
  modules.desktop.hyprland.animationSpeed = "medium"; # medium or slow
  modules.desktop.hyprland.blur.enable = true;
  modules.desktop.hyprland.opacity = 0.9; # The windows Opacity
  modules.desktop.hyprland.shadow.enable = true; # enable shadow for Hyprland
  modules.desktop.hyprland.rounding =
    10; # Rounding Corners for Hyprland Windows
  modules.desktop.hyprland.dim_inactive = true;
  modules.desktop.hyprland.plugins.hyprbars = true;
  modules.desktop.hyprland.plugins.hyprspace = false;
  modules.desktop.hyprland.plugins.bordersPlus = false;
  modules.desktop.hyprland.plugins.hyprexpo = false;
  modules.desktop.hyprland.plugins.hyprtrails = false;
  modules.desktop.hyprland.lockscreen.enable = true;
  modules.desktop.hyprland.lockscreen.type = "hyprlock";
  modules.desktop.hyprland.lockscreen.timeOut = 600; # 10min
  modules.desktop.hyprland.lockscreen.font = "";
  modules.desktop.hyprland.hyprpaper.enable = true;

  # [i18n] Date/Time & Languages
  modules.i18n.timeFormat = 12;
  modules.i18n.timezone = "Africa/Cairo"; # Select timezone
  modules.i18n.defaultLocale = "en_US.UTF-8"; # Select locale
  modules.i18n.mainlanguage = "English"; # Select the main Language.
  modules.i18n.languages = [ "arabic" "france" ]; # Add Other Languages

  # [ image_viewer ]
  modules.image_viewer.eog = true;
  modules.image_viewer.feh = true;
  modules.image_viewer.loupe = true;

  # [ Media ]
  modules.media.mpv = true;
  modules.media.vlc = true;
  modules.media.cava = false;
  modules.media.glide = false;
  modules.media.codex = true;
  modules.media.clapper = false;
  modules.media.celluloid = true;
  modules.media.jellyfin = false;
  modules.media.kdenlive = false;
  modules.media.shotcut = true;
  modules.media.music = false;

  # [networking]
  modules.networking.dnsResolver =
    "systemd-resolved"; # "dnsmasq" or "systemd-resolved"
  modules.networking.nameservers =
    [ "8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1" ]; # Google's DNS
  modules.networking.dnsmasq.settings.server = modules.networks.nameservers;
  modules.networking.networkManager = true;
  modules.networking.interfaces = {
    eno1 = {
      useDHCP = false; # Disable DHCP (so no default route or DNS is set)
      # ipv4.addresses = [{
      #   # sudo ip addr flush dev enp4s0
      #   # sudo ip addr add 192.168.10.2/24 dev enp4s0
      #   address = "192.168.10.1"; # Set static IP for local RDP
      #   prefixLength = 24;
      # }];
    };
  };
  modules.networking.wifiBackend = "iwd"; # "wpa_supplicant" OR "iwd"
  modules.networking.iwd = true;
  modules.networking.rtl8188eus-aircrack = false;
  modules.networking.waypipe = false;
  modules.networking.rtw = false;
  modules.networking.firewall.enable = true;
  modules.networking.nftables.enable = false; # Use nftables instead of iptables

  # [office]
  modules.office.siyuan = true;
  modules.office.evince = true;
  modules.office.papers = true;
  modules.office.zathura = true;
  modules.office.obsidian = true;
  modules.office.libreoffice = true;
  modules.office.translators.enable = true;

  # [ overclock ]
  modules.overclock.corectrl.enable = true;
  modules.overclock.lactd.enable = true;

  # [ Power ]
  modules.power.powerManagement.enable = true;
  modules.power.powerManagement.powertop = true;
  # Often used values: "schedutil", "ondemand", "powersave", "performance"
  modules.power.powerManagement.cpuFreqGovernor = "performance";
  modules.power.powerManagement.cpufreq.min = 800000; # 800MHz
  modules.power.powerManagement.cpufreq.max = 4100000; # 4.1GHz
  modules.power.tlp.enable = false; # TLP is not recommended for desktops
  modules.power.boot.kernelModules = [
    "amd-pstate" # AMD CPU P-State driver for better power management
    "acpi_cpufreq" # ACPI CPU frequency scaling driver
    "cpufreq_performance"
    "cpufreq_powersave"
    "cpufreq_ondemand"
    "cpufreq_conservative"
    "powernow-k8"
  ];
  modules.power.boot.kernelParams = [
    # FX CPUs do NOT have P-State.
    "amd_pstate.shared_mem=1"
    "amd_pstate=active" # Enable AMD P-State driver
  ];

  # [ Recording ]
  modules.recording.screen.enable = true;
  modules.recording.screen.gpu_recorder = false;
  modules.recording.screen.obs = false;
  modules.recording.screen.wf_recorder = false;
  modules.recording.sound.enable = false;

  # [ remote_desktop ]
  modules.remote_desktop.rdp.enable = true;

  # [resources_monitoring]
  modules.resources_monitoring.resources_app = true;
  modules.resources_monitoring.btop = {
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

  # [screenshot]
  modules.screenshot.flameshot = true;
  modules.screenshot.slurp = true;

  # [security]
  modules.security.tpm2 = false;

  # [sound_editor]
  modules.sound_editor.audacity = false;

  # [ storage ]
  modules.storage.fstrim.enable = true;
  modules.storage.beesd.enable = false;

  modules.styles = {
    # Blue, Teal, Green, Yellow, Orange, Red, Pink, Purple, Slate
    mainColor.name = "red";
    mainColor.hash = "B91C1C";
    mode = "dark"; # "dark" or "light"
    colorScheme = "prefer-dark";
    window.opacity = 0.9; # The windows Opacity
    window.blur = true; # Enable blur for windows
    window.shadow = true; # enable shadow for Hyprland
    window.rounding = 10; # rounding corners for Hyprland windwos
    window.dim_inactive = true;
    window.title.fontStyle = "bold";
    window.title.fontSize = 20;
    window.border.active.color = modules.styles.mainColor;
    window.border.active.size = 4;
    window.border.inactive.color = "#ddd8";
    window.border.inactive.size = 4;
    icons.nameInLight = "Papirus";
    icons.nameInDark = "Papirus-Dark";
    icons.package = pkgs.papirus-icon-theme;
    # "small" or "small-plus" or "medium" or "large" or "extra-large"
    icons.icon_view_size = "large"; # Set icon size for nautilus file manager.
  };

  modules.system = {
    oom = false; # user-space Out-Of-Memory (OOM) killer.
    rocm.enable =
      false; # Make Sure that your APU/GPU Supported before Enable it
    radeon = false;
    videoDrivers = [ "amdgpu" ];
    boot.plymouth.enable = true;
    boot.tmp.useTmpfs = useTmpfs;
    boot.tmp.tmpfsSize = "50%"; # Size of tmpfs
    boot.loader.timeout = 3; # seconds
    boot.loader.mode = "UEFI"; # UEFI OR BIOS
    boot.loader.manager.name =
      "SYSTEMD"; # Select The boot manager "GRUB" or "SYSTEMD
    boot.loader.manager.grub = {
      fontSize = 14;
      osProber = true;
      efiSupport = true;
      gfxmodeEfi = "1920x1080";
      devices = [ "nodev" ];
      device = "nodev"; # Let GRUB automatically detect EFI
      # nix path-info -r nixpkgs#sleek-grub-theme
      theme = with pkgs;
        (sleek-grub-theme.override {
          withStyle = "dark"; # (dark/light/orange/bigsur)
          withBanner = "GRUB Boot Manager";
        });
      extraConfig = ''
        # GRUB_DISABLE_OS_PROBER=true
        # GRUB_CMDLINE_LINUX="root=UUID=ba8daecb-c5d6-4dc9-bc51-a38b344ca6ed rootflags=subvol=@"
      '';
    };
    boot.kernelParams = [
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
      "amd_iommu=on"

      "amdgpu.tearfree=1"
      "split_lock_mitigate=off" # prevents some games from being slowed
      "random.trust_cpu=on"

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

      # "amdgpu.dc=1" # Enables Display Core (improves multi-display support)
      # "amdgpu.gpu_recovery=1" # Auto-recover from GPU hangs (safe)
      # "amdgpu.debugmask=1" # Enables some debugging logs

      # Disables HDMI/DisplayPort audio output on AMD GPUs.
      # Useful if you're not using HDMI/DP audio and want to prevent driver conflicts.
      "amdgpu.audio=0"

      # Enables Dynamic Power Management (DPM). Allows the GPU to adjust its clock and voltage for power saving and performance.
      "amdgpu.dpm=1"

      # Disables runtime power management. Helps keep the GPU always powered on (useful for debugging or fixing suspend/resume issues).
      "amdgpu.runpm=0"

      # Enables FreeSync support in video playback (if supported).
      # "amdgpu.freesync_video=1"

      "processor.ignore_ppc=1"

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
      "amdgpu.vm_fragment_size=9"

      # Set amdgpu.lockup_timeout in order to control the TDR for each ring
      # 0 (GFX): 5s (was 10s)
      # 1 (Compute): 10s (was 60s wtf)
      # 2 (SDMA): 10s (was 10s)
      # 3 (Video): 5s (was 10s)
      "amdgpu.lockup_timeout=5000,10000,10000,5000"

      "amdgpu.noretry=0" # Improve memory handling
    ];
    boot.kernelModules = [
      "amdgpu" # AMD GPU driver
      "radeon" # Legacy AMD GPU driver (for older cards)
      "k10temp" # Temperature monitoring
      "i2c_hid" # Input devices
      "binder_linux"
      "usbhid"
      "usbcore"
      "8188eu"
      "bfq"
      "coretemp"
      "fuse"
      "kvm-amd" # AMD Virtualization
      "msr"
      "uinput"
      "v4l2loopback"
      "rt2800usb"
    ];
    boot.extraModprobeConfig = ''
      options usbcore autosuspend=-1
      options binder_linux devices=binder,hwbinder,vndbinder
      options rt2800usb nohwcrypt=1
    '';
    boot.initrd.kernelModules = [ "amdgpu" "radeon" ];
    boot.blacklistedKernelModules = [ "snd_usb_audio hp_wmi" ];
    amdgpu.initrd = true;
    amdgpu.opencl = false;
    amdgpu.legacySupport = false;
    amdgpu.amdvlk = true;

    docs.enable = true;
    docs.doc.enable = true;
    docs.dev.enable = true;
    docs.info.enable = true;
    docs.nixos.enable = true;
    docs.man.enable = true;
    docs.man.generateCaches = false;
  };
  modules.terminals = {
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
    wezterm = {
      shell = modules.terminals.default.shell;
      fontFamily = modules.terminals.default.font.family;
      fontSize = modules.terminals.default.font.size;
      colorScheme = "Apple System Colors";
    };
  };

  # [users]
  modules.users.name = user.name;

  # [MS Windows]
  modules.windows.wine.enable = true;

  # [XDG]
  modules.desktop.xdg = {
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

  modules.zram.algorithm = "lz4"; # "lz4", "zstd"
}
