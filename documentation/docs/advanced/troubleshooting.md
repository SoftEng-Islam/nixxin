# 🆘 Troubleshooting Guide

This guide covers common issues and their solutions when using Nixxin.

## 🔧 General Issues

### Build Failures

#### Issue: Configuration build fails
```bash
error: build failed
```

**Solutions:**

1. Check syntax errors:
```bash
nix-instantiate --eval configuration.nix
```

2. Clean and rebuild:
```bash
sudo nixos-rebuild switch --upgrade
```

3. Check for missing dependencies:
```bash
nix flake check
```

#### Issue: Out of date inputs
```bash
error: input 'nixpkgs' is not a tree
```

**Solution:**
```bash
# Update flake inputs
nix flake update

# Clean and rebuild
sudo nixos-rebuild switch
```

### Permission Issues

#### Issue: Permission denied accessing files
```bash
error: permission denied
```

**Solutions:**

1. Fix ownership:
```bash
sudo chown -R $USER:$USER ~/.config/nixxin
```

2. Check sudo access:
```bash
sudo -v
```

3. Verify file permissions:
```bash
ls -la ~/.config/nixxin/
```

## 🖥️ Desktop Environment Issues

### Hyprland Issues

#### Issue: Hyprland won't start
```bash
error: Hyprland failed to start
```

**Solutions:**

1. Check GPU drivers:
```bash
lspci | grep -i vga
nvidia-smi  # For NVIDIA
```

2. Verify configuration:
```bash
nixxin config-check desktop.hyprland
```

3. Check logs:
```bash
journalctl -xe | grep -i hyprland
```

#### Issue: Wayland applications not working
**Solutions:**

1. Install Wayland support:
```nix
{
  desktop.hyprland = {
    enable = true;
    waylandSupport = true;
  };
}
```

2. Set environment variables:
```bash
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
```

### GNOME Issues

#### Issue: GNOME extensions not loading
**Solutions:**

1. Enable extensions:
```nix
{
  desktop.gnome = {
    enable = true;
    extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "dash-to-dock@micxgx.gmail.com"
    ];
  };
}
```

2. Restart GNOME Shell:
```bash
Alt+F2, then enter "r"
```

## 🎮 Gaming Issues

### Steam Issues

#### Issue: Steam won't launch games
**Solutions:**

1. Enable Steam with proper configuration:
```nix
{
  gaming.steam = {
    enable = true;
    proton = true;
    remotePlay = true;
  };
}
```

2. Check GPU drivers:
```bash
# NVIDIA
nvidia-smi

# AMD
radeontop

# Intel
intel_gpu_top
```

3. Verify Proton:
```bash
# Check Proton versions
ls ~/.steam/steam/steamapps/common/Proton\*/
```

#### Issue: Performance issues in games
**Solutions:**

1. Enable Gamemode:
```nix
{
  gaming.gamemode.enable = true;
}
```

2. Optimize kernel settings:
```nix
{
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };
}
```

### Wine Issues

#### Issue: Wine applications not working
**Solutions:**

1. Configure Wine properly:
```nix
{
  gaming.wine = {
    enable = true;
    tricks = ["corefonts" "d3dx9"];
  };
}
```

2. Set Wine prefix:
```bash
export WINEPREFIX=~/.wine
winecfg
```

## 💻 Development Issues

### VSCode Issues

#### Issue: VSCode extensions not installing
**Solutions:**

1. Configure VSCode extensions:
```nix
{
  development.vscode = {
    enable = true;
    extensions = [
      "ms-vscode.cpptools"
      "rust-lang.rust-analyzer"
    ];
  };
}
```

2. Check marketplace access:
```bash
code --list-extensions
```

#### Issue: Remote development not working
**Solutions:**

1. Enable remote SSH:
```nix
{
  development.vscode = {
    enable = true;
    remoteSSH = true;
  };
}
```

2. Check SSH configuration:
```bash
ssh -T localhost
```

### Docker Issues

#### Issue: Docker daemon not running
**Solutions:**

1. Enable Docker service:
```nix
{
  virtualisation.docker.enable = true;
  virtualisation.docker.autoStart = true;
}
```

2. Start Docker manually:
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

#### Issue: Permission denied with Docker
**Solutions:**

1. Add user to docker group:
```nix
{
  users.users.yourUser.extraGroups = ["docker"];
}
```

2. Rebuild and restart:
```bash
sudo nixos-rebuild switch
newgrp docker
```

## 🔊 Audio Issues

### PulseAudio Issues

#### Issue: No sound output
**Solutions:**

1. Check audio hardware:
```bash
aplay -l
arecord -l
```

2. Restart PulseAudio:
```bash
pulseaudio -k
pulseaudio --start
```

3. Check volume levels:
```bash
alsamixer
```

#### Issue: Audio crackling/popping
**Solutions:**

1. Configure audio settings:
```nix
{
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraConfig = ''
      load-module module-suspend-on-idle
    '';
  };
}
```

2. Adjust buffer size:
```bash
# Edit /etc/pulse/daemon.conf
default-fragments = 2
default-fragment-size-msec = 5
```

## 🌐 Network Issues

### WiFi Issues

#### Issue: WiFi not connecting
**Solutions:**

1. Check WiFi hardware:
```bash
lspci | grep -i network
lsusb | grep -i wireless
```

2. Enable NetworkManager:
```nix
{
  networking.networkmanager.enable = true;
}
```

3. Restart network services:
```bash
sudo systemctl restart NetworkManager
```

#### Issue: Slow WiFi speeds
**Solutions:**

1. Update drivers:
```bash
sudo nixos-rebuild switch --upgrade
```

2. Configure power management:
```nix
{
  powerManagement.enable = false;  # For WiFi stability
}
```

### VPN Issues

#### Issue: VPN connection fails
**Solutions:**

1. Configure VPN properly:
```nix
{
  services.openvpn = {
    enable = true;
    servers = {
      myvpn = {
        config = config "path/to/config.ovpn";
        autoStart = true;
      };
    };
  };
}
```

2. Check DNS settings:
```bash
nslookup google.com
```

## 📊 Performance Issues

### System Slowdown

#### Issue: System running slowly
**Solutions:**

1. Check system load:
```bash
htop
iotop
nethogs
```

2. Optimize swap:
```nix
{
  swapDevices = [{
    device = "/swapfile";
    size = 8192;  # 8GB
  }];
}
```

3. Enable zram:
```nix
{
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
}
```

### High Memory Usage

#### Issue: Memory usage too high
**Solutions:**

1. Check memory usage:
```bash
free -h
ps aux --sort=-%mem | head
```

2. Optimize services:
```nix
{
  services = {
    # Disable unused services
    printing.enable = false;
    avahi.enable = false;
  };
}
```

## 🔍 Debugging Tools

### System Information

```bash
# System info
nixos-version
uname -a

# Hardware info
lscpu
lspci
lsusb
lsof

# Package info
nix-store -q --tree /run/current-system
```

### Log Analysis

```bash
# System logs
journalctl -xe

# Service logs
journalctl -u service-name

# Boot logs
journalctl -b
```

### Configuration Validation

```bash
# Check configuration syntax
nix-instantiate --eval configuration.nix

# Check flake
nix flake check

# Test build
nixos-rebuild build
```

## 📞 Getting Help

### Community Support

1. **GitHub Issues**: [Create an issue](https://github.com/SoftEng-Islam/nixxin/issues)
2. **Discussions**: [Join the discussion](https://github.com/SoftEng-Islam/nixxin/discussions)
3. **Documentation**: Check this guide and module documentation

### Reporting Bugs

When reporting bugs, include:

1. **System Information**: NixOS version, hardware details
2. **Configuration**: Relevant parts of your configuration
3. **Error Messages**: Full error output
4. **Steps to Reproduce**: How to trigger the issue
5. **Expected vs Actual**: What you expected vs what happened

### Debug Information Collection

```bash
# Generate debug report
nixxin debug-report > debug-info.txt

# Include in bug report
cat debug-info.txt
```

---

**📖 Next:** Check [Performance Optimization](performance.md) for system tuning tips.
