# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ pkgs, ... }:
rec {
  # ----------------------------------------------
  # ---- The User Information
  # ----------------------------------------------
  # - You must Change all Values here
  user.name = "Your Name"; # Name/Identifier
  user.username = "yourusername"; # Username
  user.email = "your@email.com"; # Email
  HOME = "/home/${user.username}"; # Home Directory
  # ----------------------------------------------
  # ---- System Information And Configuration
  # ----------------------------------------------
  system.name = "nixos";
  system.hostName = "nixos"; # Hostname - CHANGE THIS
  system.architecture = "x86_64-linux"; # Replace with your system architecture

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  system.useTmpfs = true;
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
  # ----------------------------------------------
  common.EDITOR = "micro";
  common.VISUAL = "micro";
  common.TERM = "xterm-256color";
  common.webBrowser = "firefox";
  common.mainFont.name = "CaskaydiaCove Nerd Font";
  common.mainFont.package = pkgs.nerd-fonts.caskaydia-cove;

  # Color scheme
  common.primaryColor = "rgba(2677d9ff)";
  common.surfaceColor = "rgba(1e1e1eff)";

  # Media Variables
  common.videoPlayer = "";
  common.soundPlayer = "";
  common.imageViewer = "";

  # Idle settings
  common.idle = {
    delay = 0;
  };

  # Dotfiles directory
  common.dotfilesDir = "/home/${user.username}/nixxin";

  # GTK Theme
  common.gtk.GTK_THEME = "adw-gtk3-dark";
  common.gtk.theme = "adw-gtk3-dark";
  common.gtk.package = pkgs.adw-gtk3;
  common.gtk.icon_cache = true;

  # QT Settings
  common.qt.style = "Adwaita-dark";
  common.qt.platformTheme = "gtk3";
  common.qt.package = pkgs.adwaita-qt6;
  common.qt.SCALE_FACTOR = 1;

  # Icons
  common.icons.nameInLight = "Papirus";
  common.icons.nameInDark = "Papirus-Dark";
  common.icons.package = pkgs.papirus-icon-theme;
  common.icons.folder-color = "paleorange";

  # Cursor
  common.cursor.size = 24;
  common.cursor.name = "Bibata-Modern-Classic";
  common.cursor.package = pkgs.bibata-cursors;

  # Mouse settings
  common.mouse.sensitivity = -0.5;
  common.mouse.accelProfile = "flat";
  common.mouse.scrollSpeed = 1.0;
  common.mouse.naturalScroll = false;
  common.mouse.doubleClick = 800;

  # ----------------------------------------------
  # ---- Hardware Configuration
  # ----------------------------------------------
  # IMPORTANT: Adjust these settings based on your hardware
  
  # CPU Configuration - UNCOMMENT what applies to you
  common.cpu.intel = false;  # Set true if you have Intel CPU
  common.cpu.amd = true;     # Set true if you have AMD CPU
  common.cpu.zen = true;     # Set true if you have AMD Zen CPU
  common.cpu.ryzen = true;   # Set true if you have AMD Ryzen CPU
  common.cpu.ryzenMobile = false; # Set true if you have AMD Ryzen Mobile CPU
  
  # GPU Configuration - UNCOMMENT what applies to you
  common.cpu.amdGPU = true;  # Set true if you have AMD GPU
  common.cpu.nvidiaGPU = false; # Set true if you have NVIDIA GPU
  common.cpu.intelGPU = false;  # Set true if you have Intel GPU
  
  # CPU Information - ADJUST to your hardware
  common.cpu.cores = 4;       # Number of CPU cores
  common.cpu.threads = 4;     # Number of CPU threads
  common.cpu.tdp = 65;        # CPU TDP in watts
  
  # Power settings
  common.cpu.overclocking = false;
  common.cpu.undervolting = false;

  # Battery
  common.battery = false; # Set true if you have a laptop

  # ----------------------------------------------
  # ---- Modules To [ Enable/Disable ]
  # ----------------------------------------------
  # Set true to Enable, and false to Disable
  modules.pkgs.enable = true;
  modules.system.enable = true;
  modules.security.enable = true;
  modules.graphics.enable = true;
  modules.fonts.enable = true;
  modules.development.enable = true;
  modules.cli.enable = true;
  modules.browsers.enable = true;
  modules.storage.enable = true;
  modules.users.enable = true;
  modules.data_transferring.enable = true;
  modules.hacking.enable = false; # Set to false unless you need these tools
  modules.env.enable = true;
  modules.desktop.enable = true;
  modules.media.enable = true;
  modules.git.enable = true;
  modules.i18n.enable = true;
  modules.networking.enable = true;
  modules.power.enable = true;
  modules.overclock.enable = false; # Set to false unless you need this
  modules.office.enable = true;
  modules.icons.enable = true;
  modules.virtualization.enable = false; # Set to true if you use VMs
  modules.zram.enable = true;
  modules.ssh.enable = false; # Set to true if you need SSH server
  modules.ai.enable = false;
  modules.emails.enable = true;
  modules.notifications.enable = true;
  modules.printing.enable = false; # Set to true if you have a printer
  modules.android.enable = false; # Set to true if you need Android development
  modules.camera.enable = false;
  modules.recording.enable = true;
  modules.sound_editor.enable = false;
  modules.windows.enable = false; # Set to true if you need Wine/Windows support
  modules.audio.enable = true;
  modules.gaming.enable = false; # Set to true if you game
  modules.remote_desktop.enable = false;
  modules.bluetooth.enable = false; # Set to true if you have Bluetooth
  modules.community.enable = true;

  # ----------------------------------------------
  # ---- Module Configuration (Basic Setup)
  # ----------------------------------------------

  # Browsers
  modules.browsers.firefox.enable = true;
  modules.browsers.google-chrome.enable = false;
  modules.browsers.brave.enable = false;

  # Development
  modules.development.vscode = true;
  modules.development.helix = false;
  modules.development.emacs = false;
  modules.development.zedEditor = false;

  # Desktop Environment
  modules.desktop.dconf.colorScheme = "prefer-dark";
  modules.desktop.hyprland.enable = true; # Set to false if you don't use Hyprland
  modules.desktop.file_manager.default = "nautilus";

  # Terminal
  modules.terminals.default.shell = "bash"; # or "zsh"
  modules.terminals.default.terminal = {
    name = "gnome-terminal";
    package = pkgs.gnome-terminal;
  };

  # Internationalization
  modules.i18n.defaultLocale = "en_US.UTF-8";
  modules.i18n.timezone = "UTC"; # Change to your timezone
  modules.i18n.mainlanguage = "English";

  # Networking
  modules.networking.firewall.enable = true;
  modules.networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  # Power Management
  modules.power.powerManagement.enable = true;
  modules.power.powerManagement.cpuFreqGovernor = "ondemand"; # or "performance"

  # ----------------------------------------------
  # ---- System Configuration (Hardware-specific)
  # ----------------------------------------------
  # NOTE: You may need to adjust these based on your hardware
  
  # Boot configuration
  modules.system.boot.loader.mode = "UEFI"; # Change to "BIOS" if needed
  modules.system.boot.loader.manager.name = "GRUB";
  
  # Video drivers - ADJUST for your GPU
  modules.system.videoDrivers = [ "amdgpu" ]; # Use "nvidia" for NVIDIA, "intel" for Intel
  
  # Kernel modules - ADJUST for your hardware
  modules.system.boot.kernelModules = [
    "amdgpu"  # Remove if not using AMD GPU
    # Add other modules as needed for your hardware
  ];
  
  # Kernel parameters - ADJUST for your hardware
  # The following are optimized for AMD systems
  # Remove/modify if you have different hardware
  modules.system.boot.kernelParams = [
    # AMD GPU parameters (remove if not AMD)
    "amdgpu.si_support=1"
    "amdgpu.cik_support=1"
    "amdgpu.dpm=1"
    "amdgpu.dc=1"
    
    # General performance parameters
    "quiet"
    "splash"
  ];
  
  # Blacklisted modules - ADJUST for your hardware
  modules.system.boot.blacklistedKernelModules = [
    "nouveau"  # Blacklist nouveau if using NVIDIA
    # Add other modules to blacklist as needed
  ];

  # ----------------------------------------------
  # ---- XDG Default Applications
  # ----------------------------------------------
  modules.desktop.xdg.defaults = {
    webBrowser = "firefox";
    imageViewer = "org.gnome.Loupe";
    videoPlayer = "mpv";
    audioPlayer = "mpv";
    fileManager = "org.gnome.Nautilus";
    editor = "code";
    torrentApp = "org.qbittorrent.qBittorrent";
  };

  # ZRAM configuration
  modules.zram.algorithm = "lz4";
}
