# Shared user profile schema.
# Override values per-user in ./users/<name>/default.nix.
{
  pkgs,
  ...
}:
self: {
  # ----------------------------------------------
  # ---- The User Information
  # ----------------------------------------------
  # - You must Change all Values here
  user.name = "User Name"; # Name/Identifier
  user.username = "user"; # Username
  user.email = "user@example.com"; # Email
  HOME = "/home/${self.user.username}"; # Home Directory
  # ----------------------------------------------
  # ---- System Information And Configuration
  # ----------------------------------------------
  system.name = "nixos";
  system.hostName = "nixos"; # Hostname
  system.architecture = "x86_64-linux"; # Replace with your system architecture

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # system.kernel = pkgs.linuxPackages_zen;
  # system.kernel = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v2;

  system.useTmpfs = true;
  system.enableLogs = false; # To enable logs
  system.upgrade.enable = true;
  system.upgrade.allowReboot = true;
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

  # ?
  home.backupFileExtension = null;

  # ?
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
  common.webBrowser = "zen";
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
  common.primaryColor = "rgba(d9263bff)"; # the Color code without '#' tag
  common.surfaceColor = "rgba(1e1e1eff)";
  # [ Media ] Variables:
  common.videoPlayer = "";
  common.soundPlayer = "";
  common.imageViewer = "";
  # [ IDLE ] For Ex: You can set the idle-delay to 300 seconds (5 minutes) or 0 to Disable:
  common.idle = {
    delay = 0;
  };
  # [ Dotfiles ] Inforamtions ---- #
  common.dotfilesDir = "/home/${self.user.username}/nixxin"; # Absolute path of the repo
  # common.wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";

  # [ GTK ]
  # common.gtk.theme = "adw-gtk3-dark";
  # common.gtk.GTK_THEME = "adw-gtk3-dark"; # Env Variable
  # common.gtk.package = pkgs.adw-gtk3;

  common.gtk.GTK_THEME = "Colloid-Grey-Dark-Dracula"; # Env Variable
  common.gtk.theme = "Colloid-Grey-Dark-Dracula";
  common.gtk.package = pkgs.colloid-gtk-theme.override {
    colorVariants = [
      # "standard"
      # "light"
      "dark"
    ];
    themeVariants = [
      # "default"
      # "purple"
      # "pink"
      # "red"
      # "orange"
      # "yellow"
      # "green"
      # "teal"
      "grey"
      # "all"
    ];
    sizeVariants = [
      "standard"
      # "compact"
    ];

    tweaks = [
      # "nord"
      "dracula"
      # "gruvbox"
      # "everforest"
      # "catppuccin"
      "all"
      "black"
      "rimless"
      # "normal"
      "float"
    ];
  };

  common.gtk.icon_cache = true;

  # [ QT ]
  common.qt.style = "Adwaita-dark";
  # Qt platform theme plugin name; Qt ships a `gtk3` platform theme (not `gtk4`).
  common.qt.platformTheme = "gtk3"; # also used by QT_QPA_PLATFORMTHEME
  common.qt.package = pkgs.adwaita-qt6;
  common.qt.SCALE_FACTOR = 1;

  # [ ICONS ]
  # Use "Papirus" "Papirus-Dark" "Papirus-Light"
  common.icons.theme =
    if (self.modules.desktop.dconf.colorScheme == "prefer-dark") then
      self.common.icons.nameInDark
    else
      self.common.icons.nameInLight;
  common.icons.nameInLight = "Papirus";
  common.icons.nameInDark = "Papirus-Dark";
  # black, blue, brown, cyan, green, grey, indigo, magenta, orange, pink, purple, red, teal, white, yellow
  common.icons.package = pkgs.papirus-icon-theme.override { color = "paleorange"; };
  common.icons.folder-color = "paleorange";

  # [ CURSOR ]
  common.cursor.size = 24; # 16, 32, 48 or 64 Cursor Size
  common.cursor.name = "Bibata-Modern-Classic"; # or "Bibata-Modern-Ice"
  common.cursor.package = pkgs.bibata-cursors;

  common.mouse.sensitivity = -0.5;
  common.mouse.accelProfile = "flat"; # flat or adaptive
  common.mouse.scrollSpeed = 1.0;
  common.mouse.naturalScroll = false;
  common.mouse.doubleClick = 800;

  # CPU Architecture
  common.cpu.arch = "amd64"; # "amd64" or "aarch64"
  common.cpu.intel = false; # Set true if you have Intel CPU, and false if you have AMD CPU.
  common.cpu.amd = true; # Set true if you have AMD CPU, and false if you have Intel CPU.
  common.cpu.zen = true; # Set true if you have AMD Zen CPU, and false if you have non-Zen AMD CPU.
  common.cpu.ryzen = true; # Set true if you have AMD Ryzen CPU, and false if you have non-Ryzen AMD CPU
  common.cpu.ryzenMobile = false; # Set true if you have AMD Ryzen Mobile CPU, and false if you have non-Ryzen Mobile AMD CPU
  common.cpu.amdGPU = true; # Set true if you have AMD GPU, and false if you have non-AMD GPU.
  common.cpu.nvidiaGPU = false; # Set true if you have NVIDIA GPU, and false if you have non-NVIDIA GPU.
  common.cpu.intelGPU = false; # Set true if you have Intel GPU, and false if you have non-Intel GPU.
  common.cpu.tdp = 65; # Set the TDP of your CPU in watts, for better performance in some apps and games.
  common.cpu.overclocking = false; # Set true if you want to overclock your CPU, and false if you don't want to overclock your CPU.
  common.cpu.undervolting = false; # Set true if you want to undervolt your CPU, and false if you don't want to undervolt your CPU.

  # [ Battery ]
  common.battery = false; # Set true if you have a laptop with battery, and false if you have a desktop without battery.

  # ----------------------------------------------
  # ---- Modules To [ Enable/Disable ]
  # ----------------------------------------------
  # Modules: To Enable/Disable.
  # NOTE: The Options doesn't have effect if the module is disabled.
  # Set true to Enable, and false to Disable.
  modules.ai.enable = false;
  modules.android.enable = true;
  modules.audio.enable = true;
  modules.automation.enable = false;
  modules.bluetooth.enable = false;
  modules.browsers.enable = true;
  modules.camera.enable = false;
  modules.cli.enable = true;
  modules.community.enable = false;
  modules.data_transferring.enable = true;
  modules.desktop.enable = true;
  modules.development.enable = true;
  modules.emails.enable = false;
  modules.env.enable = true;
  modules.fonts.enable = true;
  modules.gaming.enable = false;
  modules.git.enable = true;
  modules.graphics.enable = true;
  modules.hacking.enable = false;
  modules.i18n.enable = true;
  modules.icons.enable = true;
  modules.media.enable = true;
  modules.networking.enable = true;
  modules.notifications.enable = true;
  modules.office.enable = true;
  modules.overclock.enable = false;
  modules.pkgs.enable = true;
  modules.power.enable = true;
  modules.printing.enable = false;
  modules.recording.enable = false;
  modules.remote_desktop.enable = false;
  modules.security.enable = true;
  modules.sound_editor.enable = false;
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
  modules.automation.browser-use.enable = false;
  modules.automation.n8n.enable = false;

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
  modules.community.telegram.enable = false;
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
  modules.development.editors.vscode.enable = false;
  modules.development.editors.zed-editor.enable = true;
  modules.development.editors.helix.enable = false;
  modules.development.editors.kiro.enable = false;
  modules.development.editors.webstorm.enable = false;
  modules.development.editors.antigravity.enable = true;
  modules.development.editors.cursor.enable = false;
  modules.development.editors.windsurf.enable = false;
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
  modules.desktop.hyprland.animationSpeed = "medium"; # medium or slow
  modules.desktop.hyprland.blur.enable = true;
  modules.desktop.hyprland.opacity = 1.0; # The windows Opacity
  modules.desktop.hyprland.shadow.enable = true; # enable shadow for Hyprland
  modules.desktop.hyprland.rounding = 15; # Rounding Corners
  modules.desktop.hyprland.border.inactive.color = "rgba(6c6c6cff)";
  modules.desktop.hyprland.border.active.color = self.common.primaryColor;
  modules.desktop.hyprland.border.size = 4;
  modules.desktop.hyprland.dim_inactive = true;
  modules.desktop.hyprland.plugins.hyprbars = true;
  modules.desktop.hyprland.plugins.hyprspace = false;
  modules.desktop.hyprland.plugins.bordersPlus = false;
  modules.desktop.hyprland.plugins.hyprexpo = false;
  modules.desktop.hyprland.plugins.hyprtrails = false;
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
  modules.gaming.steam.enable = false;
  modules.gaming.zeroad.enable = false; # Free game of ancient warfare
  modules.gaming.chess.enable = false;

  # [ Graphics ]
  modules.graphics.blender = false;
  modules.graphics.darktable = false;
  modules.graphics.davinci = false;
  modules.graphics.drawio = false;
  modules.graphics.figmaLinux = false;
  modules.graphics.gimp = false;
  modules.graphics.inkscape = false;
  modules.graphics.lunacy = false;
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
  modules.recording.screen.gpu_recorder = false;
  modules.recording.screen.obs = false;
  modules.recording.screen.wf_recorder = false;
  modules.recording.sound.enable = false;

  # [ remote_desktop ]
  modules.remote_desktop.rdp.enable = false;
  modules.remote_desktop.teamviewer.enable = false;

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
  modules.system.rocm = "none"; # none, new, old
  modules.system.videoDrivers = [ "modesetting" ];

  # [ BOOT ]
  modules.system.boot.plymouth.enable = true;
  modules.system.boot.tmp.useTmpfs = self.system.useTmpfs;
  modules.system.boot.tmp.tmpfsSize = "50%"; # Size of tmpfs
  modules.system.boot.loader.timeout = 3; # seconds
  modules.system.boot.loader.mode = "UEFI"; # UEFI OR BIOS
  modules.system.boot.loader.manager.name = "GRUB"; # "GRUB" or "SYSTEMD
  modules.system.boot.initrd.kernelModules = [

  ];
  modules.system.boot.blacklistedKernelModules = [
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
  modules.system.boot.kernelParams = [ ];
  # [ kernelModules ]
  modules.system.boot.kernelModules = [ ];
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
