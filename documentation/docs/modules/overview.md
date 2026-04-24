# 📦 Modules Overview

Nixxin provides a comprehensive collection of modules to customize your NixOS experience. Each module is designed to be modular, configurable, and easy to enable/disable.

## 🏗️ Module Structure

All modules follow a consistent structure:

```
modules/
├── category/
│   ├── default.nix          # Main module file
│   ├── specific-feature.nix # Individual components
│   └── README.md            # Module documentation
```

## 🎯 Module Categories

### 🖥️ Desktop Environment
Modern desktop environments and window managers for your daily use.

**Available Modules:**
- **Hyprland** - Dynamic tiling Wayland compositor
- **GNOME Tools** - GNOME desktop utilities
- **Sway** - Tiling Wayland compositor
- **KDE Plasma** - Full-featured desktop environment

**Configuration:**
```nix
{
  desktop.hyprland.enable = true;
  desktop.gnome.enable = false;
}
```

### 🌐 Browsers
Web browsers with optimized configurations and extensions.

**Available Modules:**
- **Firefox** - Privacy-focused browser with customizations
- **Chrome/Chromium** - Google Chrome/Chromium browser
- **Brave** - Privacy-focused browser
- **LibreWolf** - Firefox fork with enhanced privacy

**Configuration:**
```nix
{
  browsers.firefox.enable = true;
  browsers.chrome.enable = false;
  browsers.brave.enable = false;
}
```

### 💻 Development
Complete development environments for various programming languages and tools.

**Available Modules:**
- **VSCode** - Visual Studio Code with extensions
- **Helix** - Modal text editor
- **Emacs** - Extensible text editor
- **Neovim** - Modern Vim fork
- **Git Tools** - Git utilities and configurations
- **Docker** - Container platform
- **Node.js** - JavaScript runtime
- **Python** - Python development environment
- **Rust** - Rust development tools

**Configuration:**
```nix
{
  development.vscode.enable = true;
  development.git.enable = true;
  development.docker.enable = true;
  development.python.enable = true;
}
```

### 🎮 Gaming
Gaming platforms and tools for the best gaming experience on Linux.

**Available Modules:**
- **Steam** - Valve's gaming platform
- **Lutris** - Gaming platform for multiple stores
- **Wine** - Windows compatibility layer
- **Proton** - Steam Play compatibility tool
- **MangoHud** - Gaming overlay
- **Gamemode** - Performance optimization

**Configuration:**
```nix
{
  gaming.steam.enable = true;
  gaming.lutris.enable = true;
  gaming.wine.enable = true;
}
```

### 📊 Office
Productivity applications for office work and documentation.

**Available Modules:**
- **LibreOffice** - Complete office suite
- **Obsidian** - Note-taking and knowledge management
- **OnlyOffice** - Office suite
- **PDF Tools** - PDF readers and editors

**Configuration:**
```nix
{
  office.libreoffice.enable = true;
  office.obsidian.enable = true;
}
```

### 🎵 Media
Audio and video applications for entertainment and content creation.

**Available Modules:**
- **MPV** - Minimal video player
- **VLC** - Versatile media player
- **Kdenlive** - Video editor
- **Audacity** - Audio editor
- **GIMP** - Image editor
- **Inkscape** - Vector graphics editor

**Configuration:**
```nix
{
  media.mpv.enable = true;
  media.vlc.enable = false;
  media.kdenlive.enable = true;
}
```

### 🔧 System Tools
Essential system utilities and tools.

**Available Modules:**
- **Zsh** - Powerful shell with Oh My Zsh
- **Fish** - User-friendly shell
- **Git** - Version control system
- **Networking** - Network configuration tools
- **System Monitoring** - Performance monitoring tools
- **Backup Tools** - Backup and recovery utilities

**Configuration:**
```nix
{
  system.zsh.enable = true;
  system.git.enable = true;
  system.networking.enable = true;
}
```

### 🛡️ Security
Security configurations and tools to harden your system.

**Available Modules:**
- **Firewall** - Network firewall configuration
- **Hardening** - System security hardening
- **Antivirus** - Malware protection
- **VPN** - Virtual private networking
- **Encryption** - Full disk encryption

**Configuration:**
```nix
{
  security.firewall.enable = true;
  security.hardening.enable = true;
  security.vpn.enable = false;
}
```

### 🤖 AI
Artificial intelligence and machine learning tools.

**Available Modules:**
- **Ollama** - Local AI model runner
- **Claude Code** - AI-powered coding assistant
- **AI Development Tools** - ML/AI development environment

**Configuration:**
```nix
{
  ai.ollama.enable = true;
  ai.claude-code.enable = true;
}
```

### 📱 Mobile Development
Tools for mobile app development.

**Available Modules:**
- **Android Studio** - Android development IDE
- **Scrcpy** - Android screen mirroring
- **Waydroid** - Android emulator

**Configuration:**
```nix
{
  mobile.android-studio.enable = true;
  mobile.scrcpy.enable = true;
}
```

## 🔧 Module Configuration

### Basic Usage

Each module can be enabled/disabled with simple boolean flags:

```nix
{
  # Enable modules
  desktop.hyprland.enable = true;
  browsers.firefox.enable = true;
  development.vscode.enable = true;

  # Disable modules
  gaming.steam.enable = false;
  office.libreoffice.enable = false;
}
```

### Advanced Configuration

Many modules support additional configuration options:

```nix
{
  browsers.firefox = {
    enable = true;
    extensions = [
      "ublock-origin"
      "dark-reader"
    ];
    settings = {
      "browser.startup.homepage" = "https://github.com";
    };
  };

  development.vscode = {
    enable = true;
    extensions = [
      "ms-vscode.cpptools"
      "rust-lang.rust-analyzer"
    ];
    userSettings = {
      "editor.fontSize" = 14;
      "workbench.colorTheme" = "One Dark Pro";
    };
  };
}
```

## 📋 Module Dependencies

Some modules have dependencies on others:

```nix
{
  # Gaming requires graphics drivers
  gaming.steam.enable = true;
  hardware.nvidia.enable = true;  # Auto-enabled

  # Development requires Git
  development.vscode.enable = true;
  system.git.enable = true;       # Auto-enabled
}
```

## 🚀 Creating Custom Modules

You can create your own modules:

```nix
# modules/custom/my-app.nix
{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.custom.my-app;
in {
  options.custom.my-app = {
    enable = mkEnableOption "My Custom App";
    package = mkOption {
      type = types.package;
      default = pkgs.my-app;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    # Additional configuration...
  };
}
```

## 📚 Module Documentation

Each module includes detailed documentation:

- **README.md** - Overview and basic usage
- **Options** - Available configuration options
- **Examples** - Sample configurations
- **Troubleshooting** - Common issues and solutions

## 🔍 Finding Modules

To explore available modules:

```bash
# List all modules
nixxin list-modules

# Search for specific modules
nixxin search-modules browser

# Get module details
nixxin module-info development.vscode
```

---

**📖 Next:** Explore specific modules in detail or check out [Configuration Guide](../configuration/hardware.md)
