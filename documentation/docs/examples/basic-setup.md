# 🎯 Basic Setup Example

This example shows a minimal but functional Nixxin configuration suitable for everyday desktop use.

## 📋 Overview

This configuration includes:
- Basic desktop environment (Hyprland)
- Essential system tools
- Web browser (Firefox)
- Development tools (Git, VSCode)
- Basic security settings

## 🏗️ Configuration File

```nix
{
  description = "Basic Nixxin Desktop Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      basic-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
```

## ⚙️ Main Configuration

```nix
# configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/system.nix
    ./modules/security.nix
  ];

  # Basic system settings
  system.stateVersion = "24.11";
  
  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Networking
  networking.hostName = "nixxin-desktop";
  networking.networkmanager.enable = true;
  
  # Time zone and locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # User configuration
  users.users.yourname = {
    isNormalUser = true;
    description = "Your Name";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    hashedPassword = "$6$your_hashed_password";
    shell = pkgs.zsh;
  };
  
  # Enable Nixxin modules
  nixxin = {
    enable = true;
    
    # Desktop environment
    desktop = {
      hyprland.enable = true;
      gtk.theme = "Adwaita-dark";
      qt.theme = "Adwaita-dark";
    };
    
    # System tools
    system = {
      zsh.enable = true;
      git.enable = true;
      networking.enable = true;
    };
    
    # Development tools
    development = {
      vscode.enable = true;
      git.enable = true;
    };
    
    # Browsers
    browsers = {
      firefox.enable = true;
    };
    
    # Security
    security = {
      firewall.enable = true;
      hardening.enable = true;
    };
  };
  
  # System packages
  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    curl
    git
    vim
    
    # File management
    ranger
    unzip
    p7zip
    
    # System monitoring
    htop
    btop
    
    # Terminal utilities
    eza
    fzf
    ripgrep
  ];
  
  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
  ];
  
  # Services
  services = {
    # Enable printing
    printing.enable = true;
    
    # Enable sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    
    # Enable Bluetooth
    bluetooth.enable = true;
  };
  
  # Security settings
  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };
  
  # Nix settings
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  # Hardware settings
  hardware = {
    # Enable OpenGL
    opengl.enable = true;
    
    # Enable video drivers
    # Uncomment your GPU driver:
    # nvidia.modesetting.enable = true;  # NVIDIA
    # amdgpu.driver.enable = true;      # AMD
    # intel.driver.enable = true;       # Intel
  };
}
```

## 🖥️ Desktop Module

```nix
# modules/desktop.nix
{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nixxin.desktop;
in {
  options.nixxin.desktop = {
    hyprland.enable = mkEnableOption "Hyprland desktop environment";
    gtk.theme = mkOption {
      type = types.str;
      default = "Adwaita";
      description = "GTK theme name";
    };
    qt.theme = mkOption {
      type = types.str;
      default = "Adwaita";
      description = "Qt theme name";
    };
  };

  config = mkIf cfg.hyprland.enable {
    # Desktop environment
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Display manager
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # GTK theme
    gtk = {
      enable = true;
      theme = {
        name = cfg.gtk.theme;
        package = pkgs.gnome.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
    };

    # Qt theme
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = {
        name = cfg.qt.theme;
        package = pkgs.adwaita-qt;
      };
    };

    # Desktop applications
    environment.systemPackages = with pkgs; [
      # Window manager utilities
      waybar
      rofi
      fuzzel
      
      # Screenshot tools
      grim
      slurp
      
      # File manager
      thunar
      
      # Terminal
      kitty
      
      # System tray
      networkmanagerapplet
    ];

    # Enable XDG portals
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
```

## 🔧 System Module

```nix
# modules/system.nix
{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nixxin.system;
in {
  options.nixxin.system = {
    zsh.enable = mkEnableOption "Zsh shell";
    git.enable = mkEnableOption "Git version control";
    networking.enable = mkEnableOption "Network management tools";
  };

  config = {
    # Shell configuration
    programs.zsh = mkIf cfg.zsh.enable {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      shellInit = ''
        # Basic aliases
        alias ll='ls -la'
        alias la='ls -la'
        alias l='ls -l'
        alias ..='cd ..'
        alias ...='cd ../..'
        
        # Git aliases
        alias gs='git status'
        alias ga='git add'
        alias gc='git commit'
        alias gp='git push'
        alias gl='git pull'
      '';
    };

    # Git configuration
    programs.git = mkIf cfg.git.enable {
      enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        user.name = "Your Name";
        user.email = "your.email@example.com";
      };
    };

    # Networking tools
    environment.systemPackages = with pkgs; mkIf cfg.networking.enable [
      networkmanager
      iw
      wireless_tools
    ];

    # Enable NetworkManager
    networking.networkmanager.enable = mkIf cfg.networking.enable true;
  };
}
```

## 🛡️ Security Module

```nix
# modules/security.nix
{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.nixxin.security;
in {
  options.nixxin.security = {
    firewall.enable = mkEnableOption "Firewall";
    hardening.enable = mkEnableOption "System hardening";
  };

  config = {
    # Firewall configuration
    networking.firewall.enable = mkIf cfg.firewall.enable true;

    # System hardening
    security = mkIf cfg.hardening.enable {
      # Protect system files
      protectKernelImage = true;
      
      # AppArmor
      apparmor.enable = true;
      
      # Polkit
      polkit.enable = true;
    };

    # Security packages
    environment.systemPackages = with pkgs; mkIf cfg.hardening.enable [
      # Security tools
      fail2ban
      rkhunter
      chkrootkit
      
      # Encryption tools
      gnupg
      cryptsetup
    ];

    # Fail2ban service
    services.fail2ban.enable = mkIf cfg.hardening.enable true;
  };
}
```

## 🚀 Usage

### 1. Set up the configuration

```bash
# Create configuration directory
mkdir -p ~/.config/nixxin/modules

# Save the files above to their respective locations
# - flake.nix
# - configuration.nix
# - modules/desktop.nix
# - modules/system.nix
# - modules/security.nix
```

### 2. Update hardware configuration

```bash
# Generate hardware configuration
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

### 3. Build and switch

```bash
# Test build
nixos-rebuild build --flake .#basic-desktop

# Apply configuration
sudo nixos-rebuild switch --flake .#basic-desktop
```

### 4. Reboot and enjoy!

```bash
sudo reboot
```

## 🎨 Customization Tips

### Change Desktop Environment

Replace `hyprland.enable` with your preferred desktop:

```nix
nixxin.desktop = {
  hyprland.enable = false;
  gnome.enable = true;  # Or kde.enable = true
};
```

### Add More Applications

```nix
environment.systemPackages = with pkgs; [
  # Add your favorite applications
  vlc
  gimp
  libreoffice
  obsidian
];
```

### Configure Theme

```nix
nixxin.desktop = {
  gtk.theme = "Catppuccin-Mocha";
  qt.theme = "Catppuccin-Mocha";
};
```

## 📦 What's Included

- **Desktop**: Hyprland with Waybar, Rofi, and Kitty
- **Tools**: Git, Zsh, VSCode, Firefox
- **Security**: Firewall, AppArmor, Fail2ban
- **Multimedia**: PipeWire audio, Bluetooth support
- **System**: Auto cleanup, optimized Nix settings

## 🔄 Updates

To update this configuration:

```bash
# Update flake inputs
nix flake update

# Rebuild with latest packages
sudo nixos-rebuild switch --flake .#basic-desktop
```

---

**📖 Next:** Explore [Development Machine](development-machine.md) for a more advanced setup.
