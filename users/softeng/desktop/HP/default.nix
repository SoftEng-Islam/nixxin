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
  HOME = "/home/${user.username}"; # Home Directory
  # ----------------------------------------------
  # ---- System Information And Configuration
  # ----------------------------------------------
  system.name = "nixos";
  system.hostName = "nixxin"; # Hostname
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
  system.useTmpfs = true; # Disable it before install/update Linux Kernel.
  system.enableLogs = false; # To enable logs
  system.upgrade.enable = false;
  system.upgrade.allowReboot = false;
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
  common.EDITOR = "micro"; # ? EDITOR Var: used for
  common.VISUAL = "micro"; # ? VISUAL Var: used for
  common.TERM = "xterm-256color"; # ? TERM Var: used for
  common.webBrowser = "google-chrome-stable";
  common.mainFont.name = "CaskaydiaCove Nerd Font";
  common.mainFont.package = pkgs.nerd-fonts.caskaydia-cove;

  # => `static` colors to use
  #- Orange => hsl(23,  70%, 50%)
  #- Yellow => hsl(41,  70%, 50%)
  #- Green  => hsl(131, 70%, 50%)
  #- Teal   => hsl(189, 70%, 50%)
  #- Slate  => hsl(209, 70%, 50%)
  #- Blue   => hsl(213, 70%, 50%)
  #- Purple => hsl(285, 70%, 50%)
  #- Pink   => hsl(331, 70%, 50%)
  #- Red    => hsl(353, 70%, 50%)

  #- Orange => #d96b26ff
  #- Yellow => #d9a026ff
  #- Green  => #26d947ff
  #- Teal   => #26bed9ff
  #- Slate  => #2682d9ff
  #- Blue   => #2677d9ff
  #- Purple => #ac26d9ff
  #- Pink   => #d9267dff
  #- Red    => #d9263bff

  # => `graid colors ex:
  # "rgba(673ab7ff) rgba(E62D42ff) 45deg";
  common.primaryColor = "rgba(d9267dff)"; # the Color code without '#' tag
  common.surfaceColor = "rgba(1e1e1eff)";
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
  common.gtk.GTK_THEME = "adw-gtk3-dark"; # Env Variable
  common.gtk.package = pkgs.adw-gtk3;

  common.gtk.icon_cache = true;

  # [ QT ]
  common.qt.style = "Adwaita-dark";
  common.qt.platformTheme = "qt6ct";
  common.qt.package = pkgs.adwaita-qt;
  common.qt.QT_QPA_PLATFORMTHEME = "qt6ct";
  common.qt.SCALE_FACTOR = 1;
  # [ ICONS ]

  common.icons.nameInLight = "Papirus";
  common.icons.nameInDark = "Papirus-Dark";
  common.icons.package = pkgs.papirus-icon-theme;
  # common.icons.package = pkgs.papirus-icon-theme.override { color = "bluegrey"; };

  # Papirus folder color
  # black, blue, brown, cyan, green, grey, indigo, magenta, orange, pink, purple, red, teal, white, yellow
  common.icons.folder-color = "yellow";

  # [ CURSOR ]
  common.cursor.size = 24; # 16, 32, 48 or 64 Cursor Size
  common.cursor.name = "Bibata-Modern-Classic"; # or "Bibata-Modern-Ice"
  common.cursor.package = pkgs.bibata-cursors;

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
  modules.browsers.enable = true;
  modules.storage.enable = true;
  modules.users.enable = true;
  modules.data_transferring.enable = true;
  modules.hacking.enable = true;
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
  modules.zram.enable = true;
  modules.ssh.enable = false;
  modules.ai.enable = false;
  modules.emails.enable = true;
  modules.notifications.enable = true;
  modules.printing.enable = true;
  modules.android.enable = true;
  modules.camera.enable = false;
  modules.recording.enable = true;
  modules.sound_editor.enable = false;
  modules.windows.enable = true;
  modules.audio.enable = true;
  modules.gaming.enable = true;
  modules.remote_desktop.enable = false;
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
  modules.audio.rnnoise.enable = false; # Noise Canceling

  # [ Browsers ]
  modules.browsers.google-chrome.enable = true;
  modules.browsers.brave.enable = true;
  modules.browsers.firefox.enable = true;
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
  modules.community.discord.enable = true;
  modules.community.mumble.enable = false;
  modules.community.revolt.enable = false;
  modules.community.signal.enable = false;
  modules.community.slack.enable = false;
  modules.community.vesktop.enable = false;
  modules.community.zoom.enable = false;

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

  # [ Hacking ]
  modules.hacking.hashcat.enable = true;

  # [ Development ]
  modules.development.zedEditor = false;
  modules.development.emacs = true;
  modules.development.eclipse = false;
  modules.development.helix = true;
  modules.development.vscode = {
    enable = true;
    extensions_home = false;
    globalSnippets_home = false;
    userSettings_home = false;
    keybindings_home = false;
  };

  # [ desktop ]
  modules.desktop.ashell.enable = false;
  modules.desktop.tools = false;
  # $ dconf read /org/gnome/desktop/interface/color-scheme
  modules.desktop.dconf.colorScheme = "prefer-dark";
  modules.desktop.dconf.icons.nameInDark = common.icons.nameInDark;
  # "small" or "small-plus" or "medium" or "large" or "extra-large"
  modules.desktop.dconf.icons.icon_view_size =
    "large"; # Set icons size for nautilus.

  # [Emails]
  modules.emails.thunderbird = true;

  # [file_manager]
  modules.file_manager.spacedrive = false;

  # [fonts]
  modules.fonts = {
    # To Get "Path" of Font Package:
    # nix build nixpkgs#jetbrains-mono --print-out-paths --no-link
    main.name = "CaskaydiaCove Nerd Font"; # Selected Font
    main.package =
      pkgs.nerd-fonts.caskaydia-cove; # Typeface made for developers
    main.antialiasing = "grayscale";
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
  modules.gaming.steam.enable = false;
  modules.gaming.zeroad.enable = true; # Free game of ancient warfare
  modules.gaming.chess.enable = true;

  # [ Graphics ]
  modules.graphics.blender = true;
  modules.graphics.darktable = true;
  modules.graphics.davinci = false;
  modules.graphics.drawio = true;
  modules.graphics.figmaLinux = true;
  modules.graphics.gimp = true;
  modules.graphics.inkscape = true;
  modules.graphics.lunacy = true;
  modules.graphics.kolourpaint = false;

  # [ Hyprland ]
  modules.desktop.hyprland.genColorsPath =
    /home/${user.username}/.cache/hypr/colors.conf;
  modules.desktop.hyprland.animationSpeed = "medium"; # medium or slow
  modules.desktop.hyprland.blur.enable = false;
  modules.desktop.hyprland.opacity = 1.0; # The windows Opacity
  modules.desktop.hyprland.shadow.enable = false; # enable shadow for Hyprland
  modules.desktop.hyprland.rounding = 15; # Rounding Corners
  modules.desktop.hyprland.border.inactive.color = "rgba(6c6c6cff)";
  modules.desktop.hyprland.border.active.color = common.primaryColor;
  modules.desktop.hyprland.border.size = 4;
  modules.desktop.hyprland.dim_inactive = true;
  modules.desktop.hyprland.plugins.hyprbars = true;
  modules.desktop.hyprland.plugins.hyprspace = false;
  modules.desktop.hyprland.plugins.bordersPlus = false;
  modules.desktop.hyprland.plugins.hyprexpo = false;
  modules.desktop.hyprland.plugins.hyprtrails = false;
  modules.desktop.hyprland.lockscreen.enable = false;
  modules.desktop.hyprland.lockscreen.type =
    "hyprlock"; # "hyprlock" or "noctalia"
  modules.desktop.hyprland.lockscreen.timeOut = 600; # 10min
  modules.desktop.hyprland.lockscreen.font = "";
  modules.desktop.hyprland.hyprpaper.enable = true;
  modules.desktop.xwayland.enable = true; # keep enabled
  modules.desktop.keyring.enable = true; # keep enabled
  modules.desktop.polkit.enable = true; # keep enabled

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
  modules.media.codex = true; # video/sound codecs libs and packags
  modules.media.cava = false; # Audio Visualizer for Alsa
  modules.media.mpv = true; # media player
  modules.media.vlc = true; # media player
  modules.media.glide = false; # media player
  modules.media.clapper = false; # media player
  modules.media.celluloid = true; # media player
  modules.media.jellyfin = false; # media player
  modules.media.kdenlive = true; # video Editor
  modules.media.shotcut = false; # video Editor
  modules.media.music = true; # Music Player

  # [Networking]
  modules.networking.dnsResolver = "resolved"; # "dnsmasq" or "resolved"
  modules.networking.nameservers = [ "8.8.8.8" "9.9.9.9" ]; # DNS
  modules.networking.dnsmasq.settings.server = modules.networks.nameservers;
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
  modules.networking.iwd = (modules.networking.wifiBackend == "iwd");
  modules.networking.rtl8188eus-aircrack = false;
  modules.networking.waypipe = false;
  modules.networking.rtw = false;
  modules.networking.firewall.enable = true;
  modules.networking.nftables.enable = true;

  # [Office]
  modules.office.siyuan = true;
  modules.office.evince = true;
  modules.office.papers = true;
  modules.office.zathura = true;
  modules.office.obsidian = true;
  modules.office.libreoffice = true;
  modules.office.translators.enable = true;

  # [ overclock ]
  modules.overclock.corectrl.enable = false;
  modules.overclock.lactd.enable = true;

  # [ Power ]
  modules.power.powerManagement.enable = true;
  modules.power.powerManagement.powertop = false;
  # Often used values: "schedutil", "ondemand", "powersave", "performance"
  modules.power.powerManagement.cpuFreqGovernor = "performance";
  modules.power.powerManagement.cpufreq.min = 1900000; # 1.9GHz
  modules.power.powerManagement.cpufreq.max = 3900000; # 3.9GHz
  modules.power.auto-cpufreq.enable = false;
  modules.power.tuned.enable = true;
  modules.power.upower.enable = true;
  modules.power.cpupower.enable = true;
  modules.power.tlp.enable = false; # TLP is not recommended for desktops
  modules.power.boot.kernelModules = [
    # "acpi_cpufreq" # ACPI CPU frequency scaling driver
  ];

  # [ Recording ]
  modules.recording.screen.enable = true;
  modules.recording.screen.gpu_recorder = false;
  modules.recording.screen.obs = false;
  modules.recording.screen.wf_recorder = false;
  modules.recording.sound.enable = false;

  # [ remote_desktop ]
  modules.remote_desktop.rdp.enable = false;

  # [resources_monitoring]
  modules.resources_monitoring.resources_app = true;
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
  modules.sound_editor.audacity = false;

  # [ storage ]
  modules.storage.fstrim.enable = true;
  modules.storage.beesd.enable = false;

  # [ Notifications ]
  modules.notifications.dunst.enable = false;
  modules.notifications.swaync.enable = false;

  # [ SYSTEM ]
  modules.system.radeon = false;
  modules.system.oom = false; # user-space Out-Of-Memory (OOM) killer.
  modules.system.rocm.enable = false; # If your APU/GPU Support it
  modules.system.videoDrivers = [ "amdgpu" "modesetting" ];
  # [ BOOT ]
  modules.system.boot.plymouth.enable = true;
  modules.system.boot.tmp.useTmpfs = system.useTmpfs;
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
    # "hp_wmi"
    # "radeon"
    # "nouveau"
    # "nvidia"
  ];

  # [ GRUB ]
  modules.system.boot.loader.manager.grub = {
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
  # [ kernelParams ]
  modules.system.boot.kernelParams = [
    # AMD GPU optimizations
    # The oldest architectures that AMDGPU supports are Southern Islands (SI, i.e. GCN 1) and Sea Islands (CIK, i.e. GCN 2), but support for them is disabled by default. To use AMDGPU instead of the radeon driver, you can set the kernel parameters:
    # for Southern Islands (SI i.e. GCN 1) cards
    "radeon.si_support=0" # Ensures Radeon drivers don’t interfere
    "amdgpu.si_support=1"

    # for Sea Islands (CIK i.e. GCN 2) cards
    "radeon.cik_support=0"
    "amdgpu.cik_support=1"

    "amdgpu.ppfeaturemask=0xffffffff" # Unlock all gpu controls
    "amdgpu.dc=1"
    "amdgpu.dpm=1"
    "amdgpu.gpu_recovery=1"
    "amdgpu.vm_fragment_size=9"
    "amdgpu.gttsize=40000"
    "amdgpu.dcfeaturemask=0x1" # Enable Dynamic Power Management
    "amdgpu.dcdebugmask=0x10" # AMD GPU support
    "amdgpu.sg_display=0" # Disable scatter-gather display
    "amdgpu.bapm=1" # Disable bidirectional APM

    # Disables AMD's IOMMU (Input-Output Memory Management Unit).
    # May improve compatibility or performance, especially on systems where IOMMU causes issues (like hangs or USB problems).
    # ⚠️ Not suitable if you use VFIO, PCI passthrough, or some types of sandboxing.
    "amd_iommu=on"

    "thermal.off=1"
    "random.trust_cpu=on" # ?
    "tsc=reliable"
    "clocksource=tsc"
    "no_timer_check"

    "pci=noacpi"
    "acpi=off"
    # "acpi=ht"
    "pnpacpi=off"
    "noapic"
    "nolapic"

    # Sets the number of hardware job queues (rings) that the AMD GPU scheduler can submit in parallel.
    # "amdgpu.sched_hw_submission=4"

    # Disables the Linux audit subsystem.
    # Reduces kernel log noise and slightly improves performance, especially on systems that don’t need SELinux/AppArmor audit trails.
    "audit=0"

    # Disables HDMI/DisplayPort audio output on AMD GPUs.
    # Useful if you're not using HDMI/DP audio and want to prevent driver conflicts.
    "amdgpu.audio=0"
  ];
  # [ kernelModules ]
  modules.system.boot.kernelModules = [
    "amdgpu" # AMD GPU driver
    "k10temp" # Temperature monitoring
    "i2c_hid" # Input devices
    "usbhid"
    "usbcore"
    "bfq"
    "fuse"
    "kvm-amd" # AMD Virtualization
    "msr"
    "uinput"
    # Generic DRM helpers (usually auto‑loaded, but explicit for determinism)
    "drm"
    "drm_kms_helper"
  ];
  # [ extraModprobeConfig ]
  modules.system.boot.extraModprobeConfig = ''
    options usbcore autosuspend=-1
    options rt2800usb nohwcrypt=1
  '';
  # [ AMDGPU ]
  modules.system.amdgpu.initrd = true;
  modules.system.amdgpu.opencl = true;
  modules.system.amdgpu.legacySupport = true;
  # [ Docs ]
  modules.system.docs.enable = true;
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
      shell = modules.terminals.default.shell;
      fontFamily = modules.terminals.default.font.family;
      fontSize = modules.terminals.default.font.size;
      colorScheme = "Abernathy";
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
      # $ xdg-mime default google-chrome.desktop x-scheme-handler/http
      # $ xdg-mime default google-chrome.desktop x-scheme-handler/https

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
