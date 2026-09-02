{
  pkgs,
  ...
}:
self: {
  user.name = "Islam Ahmed";
  user.username = "softeng";
  user.email = "softeng.islam@gmail.com";

  system.hostName = "nixxin";
  system.architecture = "x86_64-linux";

  # ----------------------------------------------
  # ---- Modules To [ Enable/Disable ]
  # ----------------------------------------------
  # Modules: To Enable/Disable.
  # NOTE: The Options doesn't have effect if the module is disabled.
  # Set true to Enable, and false to Disable.
  modules.ai.enable = false;
  modules.android.enable = true;
  modules.audio.enable = true;
  modules.automation.enable = true;
  modules.bluetooth.enable = false;
  modules.browsers.enable = true;
  modules.camera.enable = true;
  modules.cli.enable = true;
  modules.community.enable = true;
  modules.data_transferring.enable = true;
  modules.desktop.enable = true;
  modules.development.enable = true;
  modules.emails.enable = true;
  modules.env.enable = true;
  modules.fonts.enable = true;
  modules.gaming.enable = true;
  modules.git.enable = true;
  modules.graphics.enable = true;
  modules.hacking.enable = true;
  modules.i18n.enable = true;
  modules.icons.enable = true;
  modules.media.enable = true;
  modules.networking.enable = true;
  modules.notifications.enable = true;
  modules.office.enable = true;
  modules.overclock.enable = false;
  modules.pkgs.enable = true;
  modules.power.enable = true;
  modules.printing.enable = true;
  modules.recording.enable = true;
  modules.remote_desktop.enable = true;
  modules.security.enable = true;
  modules.sound_editor.enable = true;
  modules.ssh.enable = false;
  modules.storage.enable = true;
  modules.system.enable = true;
  modules.users.enable = true;
  modules.virtualization.enable = true;
  modules.windows.enable = false;
  modules.zram.enable = true;

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

  # [Automation]
  modules.automation.browser-use.enable = true;
  modules.automation.n8n.enable = true;

  # [ Browsers ]
  modules.browsers.google-chrome.enable = false;
  modules.browsers.brave.enable = false;
  modules.browsers.firefox.enable = true;
  modules.browsers.firefox-beta.enable = false;
  modules.browsers.microsoft-edge.enable = false;

  # [ cli ] Collection of useful CLI apps/terminals/shells
  modules.cli.prompt.enable = true;
  modules.cli.shells.enable = true;
  modules.cli.terminals.enable = true;
  # utilities
  modules.cli.utilities.enable = true;
  modules.cli.utilities.bat = true;
  modules.cli.utilities.aider-chat = true;
  modules.cli.utilities.direnv = true;
  modules.cli.utilities.atuin = true;
  modules.cli.utilities.charm = true;
  modules.cli.utilities.claude-code = false;
  modules.cli.utilities.eza = true;
  modules.cli.utilities.fzf = true;
  modules.cli.utilities.glow = true;
  modules.cli.utilities.gnused = true;
  modules.cli.utilities.gpg = true;
  modules.cli.utilities.grep = true;
  modules.cli.utilities.jujutsu = true;
  modules.cli.utilities.nh = true;
  modules.cli.utilities.nurl = true;
  modules.cli.utilities.ripgrep = true;
  modules.cli.utilities.ssh = false;
  modules.cli.utilities.zoxide = true;
  modules.cli.utilities.fd = true;
  modules.cli.utilities.lf = false;

  # [ community ]
  modules.community.telegram.enable = true;
  modules.community.ferdium.enable = false;
  modules.community.discord.enable = false;
  modules.community.mumble.enable = false;
  modules.community.revolt.enable = false;
  modules.community.signal.enable = false;
  modules.community.slack.enable = false;
  modules.community.vesktop.enable = false;
  modules.community.zoom.enable = false;

  # [ data_transferring ] Command-Line/Apps Download Utilities
  modules.data_transferring.aria.enable = true;
  modules.data_transferring.ariang.enable = true;
  modules.data_transferring.axel.enable = false;
  modules.data_transferring.bitmagnet.enable = false;
  modules.data_transferring.curl.enable = true;
  modules.data_transferring.deluge.enable = false;
  modules.data_transferring.libtorrent-rasterbar.enable = false;
  modules.data_transferring.lux.enable = false;
  modules.data_transferring.media-downloader.enable = false;
  modules.data_transferring.motrix.enable = false;
  modules.data_transferring.persepolis.enable = false;
  modules.data_transferring.qbittorrent.enable = true;
  modules.data_transferring.transmission.enable = false;
  modules.data_transferring.varia.enable = false;
  modules.data_transferring.webtorrent_desktop.enable = false;
  modules.data_transferring.wget2.enable = true;
  modules.data_transferring.yt-dlp.enable = true;

  # [ Hacking ]
  modules.hacking.hashcat.enable = false;

  # [ Development ]
  modules.development.api-tools.enable = false;
  modules.development.cloud-tools.enable = false;

  # Databases
  modules.development.databases.enable = false;
  modules.development.databases.postgresql.enable = false;
  modules.development.databases.mariadb.enable = false;
  modules.development.databases.redis.enable = false;
  modules.development.databases.mongodb.enable = false;
  modules.development.databases.tools.enable = false;

  # Languages
  modules.development.languages.enable = false;
  modules.development.languages.rust.enable = false;
  modules.development.languages.python.enable = false;
  modules.development.languages.ruby.enable = false;
  modules.development.languages.go.enable = false;

  # js-engines
  modules.development.js-engines.enable = false;
  modules.development.js-engines.nodejs.enable = false;
  modules.development.js-engines.denojs.enable = false;

  # Editors
  modules.development.editors.enable = true;
  modules.development.editors.vscode.enable = true;
  modules.development.editors.zed-editor.enable = true;
  modules.development.editors.helix.enable = false;
  modules.development.editors.kiro.enable = true;
  modules.development.editors.webstorm.enable = false;
  modules.development.editors.antigravity.enable = true;
  modules.development.editors.cursor.enable = true;
  modules.development.editors.windsurf.enable = true;
  modules.development.editors.codex.enable = true;

  # [ desktop ]
  modules.desktop.tools = false;
  # $ dconf read /org/gnome/desktop/interface/color-scheme
  modules.desktop.dconf.colorScheme = "prefer-dark";
  modules.desktop.dconf.icons.nameInDark = self.common.icons.nameInDark;
  # "small" or "small-plus" or "medium" or "large" or "extra-large"
  modules.desktop.dconf.icons.icon_view_size = "extra-large"; # Set icons size for nautilus.

  # [ desktop ] [ Hyprland ]
  modules.desktop.hyprland.genColorsPath = "/home/${self.user.username}/.cache/hypr/colors.conf";

  # ╔═══════════════════════════════════════════════════════════════════════╗
  # ║                   PERFORMANCE OPTIMIZATIONS APPLIED                   ║
  # ║              Tuned for AMD Ryzen 5 3400G APU (Vega 11)               ║
  # ╚═══════════════════════════════════════════════════════════════════════╝

  # Animation speed: faster = better performance on APU
  # Options: "fast" (best perf) | "medium" (balanced) | "slow" (eye candy)
  modules.desktop.hyprland.animationSpeed = "medium"; # Balanced performance

  # Blur: Keep enabled but optimized (size=3, passes=1 in decoration.nix)
  # Set to false if you need maximum FPS in games
  modules.desktop.hyprland.blur.enable = true;

  modules.desktop.hyprland.opacity = 1.0; # The windows Opacity

  # Shadows: Enabled with reduced range (15 instead of default 20)
  # Minimal performance impact with current settings
  modules.desktop.hyprland.shadow.enable = true;

  # Rounding: 15 is fine, minimal GPU impact
  modules.desktop.hyprland.rounding = 15;

  modules.desktop.hyprland.border.inactive.color = "rgba(6c6c6cff)";
  modules.desktop.hyprland.border.active.color = self.common.primaryColor;
  modules.desktop.hyprland.border.size = 4;

  # Dim inactive: Helps focus but adds slight GPU work
  modules.desktop.hyprland.dim_inactive = true;

  # ╔═══════════════════════════════════════════════════════════════════════╗
  # ║                         PLUGIN CONFIGURATION                          ║
  # ║  Keep only essential plugins enabled for best APU performance         ║
  # ╚═══════════════════════════════════════════════════════════════════════╝

  modules.desktop.hyprland.plugins.hyprbars = true; # Title bars - lightweight ✓
  modules.desktop.hyprland.plugins.hyprspace = false; # Workspace overview - disabled for perf
  modules.desktop.hyprland.plugins.bordersPlus = false; # Extra borders - disabled for perf
  modules.desktop.hyprland.plugins.hyprexpo = false; # Expo view - disabled for perf
  modules.desktop.hyprland.plugins.hyprtrails = false; # Cursor trails - disabled for perf

  modules.desktop.hyprland.lockscreen.timeOut = 300; # 10min
  modules.desktop.hyprland.lockscreen.font = "";
  modules.desktop.hyprland.hyprpaper.enable = true;
  modules.desktop.xwayland.enable = true; # keep enabled
  modules.desktop.keyring.enable = true; # keep enabled
  modules.desktop.polkit.enable = true; # keep enabled

  # [ desktop ] [file_manager]
  modules.desktop.file_manager.default = "nautilus"; # [dolphin, nautilus, nemo, spacedrive, thunar]
  modules.desktop.file_manager.mime = "org.gnome.Nautilus";
  modules.desktop.file_manager.dolphin = false;
  modules.desktop.file_manager.nautilus = true;
  modules.desktop.file_manager.nemo = false;
  modules.desktop.file_manager.spacedrive = false;
  modules.desktop.file_manager.thunar = false;

  # [ image_viewer ]
  modules.desktop.image_viewer.enable = true;
  modules.desktop.image_viewer.eog.enable = false;
  modules.desktop.image_viewer.feh.enable = false;
  modules.desktop.image_viewer.loupe.enable = true;

  # [Emails]
  modules.emails.thunderbird = false;

  # [fonts]
  modules.fonts = {
    # To Get "Path" of Font Package:
    # nix build nixpkgs#jetbrains-mono --print-out-paths --no-link
    main.name = "CaskaydiaCove Nerd Font"; # Selected Font

    # Typeface made for developers
    main.package = pkgs.nerd-fonts.caskaydia-cove;

    main.antialiasing = "standard";
    main.hinting = "full"; # (one of "none", "slight", "medium", "full")
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
  modules.gaming.steam.enable = true;
  modules.gaming.zeroad.enable = false; # Free game of ancient warfare
  modules.gaming.chess.enable = true;

  # [ Graphics ]
  modules.graphics.blender = true;
  modules.graphics.darktable = false;
  modules.graphics.davinci = false;
  modules.graphics.drawio = false;
  modules.graphics.figmaLinux = false;
  modules.graphics.gimp = false;
  modules.graphics.inkscape = false;
  modules.graphics.lunacy = true;
  modules.graphics.kolourpaint = false;

  # [i18n] Date/Time & Languages
  modules.i18n.timeFormat = 12;
  modules.i18n.timezone = "Africa/Cairo"; # Select timezone
  modules.i18n.defaultLocale = "en_US.UTF-8"; # Select locale
  modules.i18n.mainlanguage = "English"; # Select the main Language.
  modules.i18n.languages = [
    "arabic"
    "france"
  ]; # Add Other Languages

  # [ Media ]
  modules.media.codex = true; # Video/Sound codecs libs and packags
  modules.media.cava = false; # Audio Visualizer for Alsa
  modules.media.mpv = true; # Media Player
  modules.media.vlc = false; # Media Player
  modules.media.glide = false; # media player
  modules.media.clapper = false; # media player
  modules.media.celluloid = false; # media player
  modules.media.jellyfin = false; # media player
  modules.media.kdenlive = false; # video Editor
  modules.media.shotcut = false; # video Editor
  modules.media.music = false; # Music Player

  # [Networking]
  modules.networking.dnsResolver = "dnsmasq"; # "dnsmasq" or "resolved"
  modules.networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ]; # DNS
  modules.networking.dnsmasq.settings.server = self.modules.networking.nameservers;
  modules.networking.interfaces = {
    # eno1 = {
    # useDHCP = false; # Disable DHCP (so no default route or DNS is set)
    # ipv4.addresses = [{
    #   # sudo ip addr flush dev enp4s0
    #   # sudo ip addr add 192.168.10.2/24 dev enp4s0
    #   address = "192.168.10.1"; # Set static IP for local RDP
    #   prefixLength = 24;
    # }];
    # };
  };
  modules.networking.wifiBackend = "wpa_supplicant"; # "wpa_supplicant" OR "iwd"
  modules.networking.iwd = (self.modules.networking.wifiBackend == "iwd");
  modules.networking.rtl8188eus = false;
  modules.networking.waypipe = false;
  modules.networking.rtw = false;
  modules.networking.firewall.enable = true;
  modules.networking.nftables.enable = true;

  # [Office]
  modules.office.siyuan = true;
  modules.office.evince = true;
  modules.office.papers = false;
  modules.office.obsidian = true;
  modules.office.libreoffice = false;
  modules.office.translators.enable = false;

  # [ overclock ]
  modules.overclock.corectrl.enable = false;
  modules.overclock.lactd.enable = false;

  # [ Power ]
  modules.power.powerManagement.enable = true;
  modules.power.powerManagement.powertop = false;
  # Often used values: "schedutil", "ondemand", "powersave", "performance"
  modules.power.powerManagement.cpuFreqGovernor = "performance";
  # modules.power.powerManagement.cpufreq.min = 1900000; # 1.9GHz
  # modules.power.powerManagement.cpufreq.max = 3900000; # 3.9GHz
  modules.power.auto-cpufreq.enable = false;
  modules.power.tuned.enable = false;
  modules.power.upower.enable = true;
  modules.power.cpupower.enable = true;
  modules.power.tlp.enable = false; # TLP is not recommended for desktops
  modules.power.boot.kernelModules = [
    "acpi_cpufreq" # ACPI CPU frequency scaling driver
    "cpufreq_performance"
    # "cpufreq_powersave"
    # "cpufreq_ondemand"
    # "cpufreq_conservative"
  ];

  # [ Recording ]
  modules.recording.screen.gpu_recorder = true;
  modules.recording.screen.obs = true;
  modules.recording.screen.wf_recorder = true;
  modules.recording.sound.enable = true;

  # [ remote_desktop ]
  modules.remote_desktop.rdp.enable = false;
  modules.remote_desktop.teamviewer.enable = true;

  # [resources_monitoring]
  modules.resources_monitoring.btop = {
    enable = true;
    theme = "adapta";
    background = "False";
    rounded = "True";
    update = 500; # Update time in milliseconds
    temperature = "celsius"; # "celsius", "fahrenheit", "kelvin", "rankine"
    clock = "%I:%M %p";
    # run to get Network Interface Name: ip addr show
    net_iface = "eth0";
  };

  # [screenshot]
  modules.screenshot.flameshot = true;
  modules.screenshot.slurp = true;

  # [security]
  modules.security.tpm2 = false;

  # [sound_editor]
  modules.sound_editor.audacity = true;

  # [ storage ]
  modules.storage.fstrim.enable = true;
  modules.storage.beesd.enable = false;

  # [ Notifications ]
  modules.notifications.dunst.enable = false;
  modules.notifications.swaync.enable = false;

  # [ SYSTEM ]
  modules.system.radeon = false;
  modules.system.oom = false; # user-space Out-Of-Memory (OOM) killer.
  modules.system.rocm = "old"; # none, new, old — Picasso APU (gfx902)
  modules.system.videoDrivers = [ "modesetting" ];

  # [ BOOT ]
  modules.system.boot.plymouth.enable = true;
  modules.system.boot.tmp.useTmpfs = self.system.useTmpfs;
  modules.system.boot.tmp.tmpfsSize = "50%"; # Size of tmpfs
  modules.system.boot.loader.timeout = 3; # seconds
  modules.system.boot.loader.mode = "UEFI"; # UEFI OR BIOS
  modules.system.boot.loader.manager.name = "GRUB"; # "GRUB" or "SYSTEMD
  modules.system.boot.initrd.kernelModules = [
    # GPU/Display modules
    "amdgpu"
    "drm"
    "drm_kms_helper"
    "gpu_sched"
  ];
  modules.system.boot.blacklistedKernelModules = [
    "hp_wmi"
    "radeon"
    "psmouse"
    "sunrpc"
    "snd_seq_dummy"
    "nouveau"
    "nvidia"
  ];
  # [ GRUB ]
  modules.system.boot.loader.manager.grub = {
    fontSize = 14;
    osProber = false;
    efiSupport = true;
    gfxmodeEfi = "2560x1440,1920x1080,auto";
    devices = [ "nodev" ];
    device = "nodev"; # Let GRUB automatically detect EFI
    # nix path-info -r nixpkgs#sleek-grub-theme
    theme =
      with pkgs;
      (sleek-grub-theme.override {
        withStyle = "dark"; # (dark/light/orange/bigsur)
        withBanner = "GRUB Boot Manager";
      });
    extraConfig = ''
      # GRUB_DISABLE_OS_PROBER=true
      # GRUB_CMDLINE_LINUX="root=UUID=ba8daecb-c5d6-4dc9-bc51-a38b344ca6ed rootflags=subvol=@"
    '';
  };
  # [ kernelParams ]
  modules.system.boot.kernelParams = [
    # AMD GPU optimizations

    # --- MEMORY TUNING ---
    # --- MEMORY TUNING (Based on 16GB Total RAM / 4GB Dedicated VRAM) ---
    # Configure TTM pages limit: 4GB dynamic memory for the GPU
    "ttm.pages_limit=1048576"

    # Optimize VM fragment handling for APU (Remains perfectly correct!)
    "amdgpu.vm_fragment_size=9"

    # --- PERFORMANCE & STABILITY ---
    # PCIe ASPM (Active State Power Management) can cause instability with some GPUs
    "amdgpu.aspm=0" # Disable ASPM for AMD GPU specifically
    "pcie_aspm=off" # Disable ASPM globally for all PCIe devices

    # AMD GPU display and features
    "amdgpu.vm_update_mode=3" # Use CPU for page table updates (best for APUs)
    "amdgpu.modeset=1" # Enable kernel mode setting (required)
    "amdgpu.dc=1" # Enable Display Core driver (required for modern features)
    "amdgpu.ppfeaturemask=0xffffffff" # Enable all PowerPlay features
    "amdgpu.audio=0" # Disable HDMI/DP audio if not using it

    # --- CPU PERFORMANCE (Ryzen 5 3400G - Zen+) ---
    # REMOVED: amd_prefcore=disable - Let the CPU use its preferred cores for better performance!
    # Preferred core selection improves single-threaded performance on Zen+

    # --- SYSTEM OPTIMIZATION ---
    "audit=0" # Disable audit system for performance
    "random.trust_cpu=on" # Trust CPU's RNG for faster boot
    "tsc=reliable" # Use TSC as reliable clocksource
    "clocksource=tsc" # Force TSC clocksource
    "no_timer_check" # Skip timer check for faster boot

    # --- VIRTUALIZATION ---
    "iommu=pt" # Passthrough mode for IOMMU (better VM performance)
    "amd_iommu=on" # Enable AMD IOMMU

    # --- USB & POWER ---
    "usbcore.autosuspend=-1" # Disable USB autosuspend

    # --- BOOT OPTIMIZATION ---
    "noresume" # Disable hibernate resume (faster boot)
    "fbcon=nodefer" # Prevent blanking during boot
    "vt.global_cursor_default=0" # Hide cursor for cleaner boot
    "logo.nologo" # Disable kernel logo

    # --- SCHEDULER & THREADING ---
    "skew_tick=1" # Reduce timer interrupt clustering
    "threadirqs" # Thread IRQs for better real-time performance
    "preempt=full" # Full preemption (lower latency)
    "smt=on" # Enable simultaneous multithreading (8 threads)

    # --- CPU FREQUENCY ---
    "cpufreq.default_governor=performance" # Performance governor for desktops
    "processor.ignore_ppc=1" # Ignore processor performance control limits

    # --- SECURITY & MONITORING ---
    "tpm.disable_pcr_integrity=1" # Disable TPM PCR integrity checking
    "msr.allow_writes=on" # Allow MSR writes for overclocking tools
    "nowatchdog" # Disable hardware watchdog
    "nosoftlockup" # Disable soft lockup detection

    # --- MEMORY & WORKQUEUE ---
    "page_alloc.shuffle=1" # Randomize page allocator freelists (security + performance)
    "workqueue.power_efficient=false" # Disable power-efficient workqueues for performance

    # --- OTHER ---
    "lockdown=off" # Allow kernel tuning and eBPF tracing
  ];
  # [ kernelModules ]
  modules.system.boot.kernelModules = [
    # CPU Frequency Scaling
    "acpi-cpufreq" # ACPI-based CPU frequency driver for AMD
    "cpufreq_performance" # Performance governor module

    # CPU Monitoring
    "k10temp" # AMD Family 10h+ temperature sensor (works for Zen+)

    # USB Support
    "usbhid" # USB Human Interface Device support
    "usbcore" # USB core support

    # I/O Scheduler
    "bfq" # Budget Fair Queueing scheduler

    # Filesystem
    "fuse" # Filesystem in Userspace

    # Virtualization
    "kvm-amd" # AMD KVM virtualization support

    # System Control
    "msr" # Model-Specific Register support (for CPU tuning)
    "uinput" # User-level input driver support

    # Graphics (DRM - Direct Rendering Manager)
    "drm" # Core DRM support
    "drm_kms_helper" # Kernel Mode Setting helpers
    # Note: amdgpu module is loaded automatically via initrd
  ];
  # [ extraModprobeConfig ]
  modules.system.boot.extraModprobeConfig = ''
    options usbcore autosuspend=-1
    options rt2800usb nohwcrypt=1
  '';
  # [ AMDGPU ]
  modules.system.amdgpu.initrd = true;
  modules.system.amdgpu.opencl = true;
  modules.system.amdgpu.legacySupport = false;
  # [ Docs ]
  modules.system.docs.enable = false;
  modules.system.docs.doc.enable = true;
  modules.system.docs.dev.enable = true;
  modules.system.docs.info.enable = true;
  modules.system.docs.nixos.enable = true;
  modules.system.docs.man.enable = true;
  modules.system.docs.man.generateCaches = false;

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
      shell = self.modules.terminals.default.shell;
      fontFamily = self.modules.terminals.default.font.family;
      fontSize = self.modules.terminals.default.font.size;
      colorScheme = "Noctalia";
    };
  };

  # [users]
  modules.users.name = self.user.name;
  modules.users.defaultShell = pkgs.zsh;
  modules.users.uid = 1000;
  modules.users.hashedPassword = "$y$j9T$5HywFRGm/t.0VjspGLm8./$GtocDydBdCVWhVq8XaZnIUWUebqMQsS5rjJp7tSsRW/";
  modules.users.managedGroups = [
    "uinput"
    "input"
    "video"
  ];
  modules.users.extraGroups = [
    "${self.user.username}"
    "adbusers"
    "audio"
    "colord"
    "corectrl"
    "dialout"
    "disk"
    "fuse"
    "git"
    "input"
    "kvm"
    "libvirtd"
    "lp"
    "lxd"
    "mysql"
    "network"
    "networkmanager"
    "nix"
    "plugdev"
    "podman"
    "polkitd"
    "power"
    "qemu"
    "realtime"
    "render"
    "rtkit"
    "sambashare"
    "storage"
    "systemd-journal"
    "systemd-resolve"
    "tss"
    "tty"
    "uucp"
    "vboxusers"
    "video"
    "waydroid"
    "wheel"
    "wireshark"
  ];
  modules.users.packages = with pkgs; [ thunderbird ];

  # [MS Windows Support]
  # modules.windows.
  # [XDG]
  modules.desktop.xdg = {
    # Select Your Default Apps:
    defaults = {
      #! [NOTICE]:
      #! - Make Sure you have install/enable the apps to use as default.
      #! - Write The name of apps without ".desktop" like:
      #! - - [ "microsoft-edge" ] , Not [ "microsoft-edge.desktop" ]
      # $ xdg-mime default google-chrome.desktop x-scheme-handler/http
      # $ xdg-mime default google-chrome.desktop x-scheme-handler/https

      # find /nix/store/ -name "*edge*.desktop"
      # or
      # fd -g '*edge*.desktop' /nix/store/

      # Default Web Browser, Ex:
      # - "zen"
      # - "microsoft-edge"
      # - "brave-browser"
      # - "google-chrome"
      webBrowser = "zen";

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
