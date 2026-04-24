# 💻 Hardware Support

This guide covers hardware configuration and driver support in Nixxin.

## 🖥️ CPU Configuration

### Intel CPUs

```nix
{
  # Enable Intel microcode updates
  hardware.cpu.intel.updateMicrocode = true;
  
  # Enable Intel graphics
  hardware.intelgpu.enable = true;
  
  # Power management
  powerManagement.cpuFreqGovernor = "performance";  # or "powersave"
}
```

### AMD CPUs

```nix
{
  # Enable AMD microcode updates
  hardware.cpu.amd.updateMicrocode = true;
  
  # Enable AMD graphics
  hardware.amdgpu.driver.enable = true;
  
  # Power management
  powerManagement.cpuFreqGovernor = "ondemand";
}
```

## 🎮 GPU Configuration

### NVIDIA Graphics

```nix
{
  # Enable NVIDIA proprietary driver
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;  # Set to true for open source driver
    
    # Package selection
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # Prime support (laptops with hybrid graphics)
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  
  # Enable OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
```

### AMD Graphics

```nix
{
  # Enable AMD driver
  hardware.amdgpu.driver.enable = true;
  
  # Enable OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  
  # Vulkan support
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
}
```

### Intel Graphics

```nix
{
  # Enable Intel driver
  hardware.intelgpu.enable = true;
  
  # Enable OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  
  # VA-API for video acceleration
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl32
  ];
}
```

## 🖱️ Input Devices

### Trackpad Configuration (Laptops)

```nix
{
  # Enable libinput for touchpad support
  services.libinput.enable = true;
  
  # Touchpad configuration
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      accelProfile = "adaptive";
    };
  };
}
```

### Gaming Peripherals

```nix
{
  # Enable support for gaming mice and keyboards
  hardware.openrazer.enable = true;
  hardware.openrazer.users = ["your-username"];
  
  # Steam controller support
  hardware.steam-hardware.enable = true;
}
```

## 🔊 Audio Configuration

### PulseAudio Configuration

```nix
{
  # Enable PulseAudio
  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    
    # Additional modules
    extraModules = [pkgs.pulseaudio-modules-bt];
  };
  
  # ALSA support
  hardware.alsa.enablePersistence = true;
}
```

### PipeWire Configuration (Recommended)

```nix
{
  # Enable PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # JACK support
    jack.enable = true;
    
    # Low latency configuration
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
      };
    };
  };
  
  # Enable real-time scheduling
  security.rtkit.enable = true;
}
```

## 🌐 Network Configuration

### WiFi Support

```nix
{
  # Enable NetworkManager
  networking.networkmanager.enable = true;
  
  # WiFi regulatory domain
  networking.wireless.regulatoryDomain = "US";
  
  # Enable WiFi firmware
  hardware.enableRedistributableFirmware = true;
}
```

### Bluetooth Support

```nix
{
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Control";
      };
    };
  };
  
  # Bluetooth GUI tools
  services.blueman.enable = true;
}
```

## 💾 Storage Configuration

### SSD Optimization

```nix
{
  # Enable fstrim for SSDs
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";
  
  # Enable swap on zram
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
  
  # Enable tmpfs for /tmp
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";
}
```

### RAID Configuration

```nix
{
  # Enable mdadm for RAID
  environment.systemPackages = [pkgs.mdadm];
  
  # RAID arrays
  boot.initrd.services.swraid.enable = true;
  boot.initrd.services.swraid.enableAutodetection = true;
}
```

### Encryption

```nix
{
  # Enable LUKS encryption
  boot.initrd.luks.devices = {
    luks-root = {
      device = "/dev/disk/by-uuid/your-uuid";
      preLVM = true;
      allowDiscards = true;
    };
  };
  
  # Enable cryptsetup
  environment.systemPackages = [pkgs.cryptsetup];
}
```

## 🖥️ Display Configuration

### Multiple Monitors

```nix
{
  # Configure multiple monitors
  services.xserver = {
    screenSection = ''
      Monitor "DVI-I-1"
        Option "PreferredMode" "1920x1080"
      Monitor "HDMI-1"
        Option "PreferredMode" "1920x1080"
    '';
    
    deviceSection = ''
      Option "Monitor-DVI-I-1" "DVI-I-1"
      Option "Monitor-HDMI-1" "HDMI-1"
    '';
  };
}
```

### High DPI Displays

```nix
{
  # Enable HiDPI support
  services.xserver.dpi = 192;
  environment.variables = {
    GDK_SCALE = "2";
    QT_SCALE_FACTOR = "2";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  
  # Font scaling
  fonts.fontconfig.defaultSizes = {
    desktop = 16;
    applications = 14;
    terminal = 18;
  };
}
```

## 🔧 Power Management

### Laptop Power Management

```nix
{
  # Enable TLP for power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # Enable USB autosuspend
      USB_AUTOSUSPEND = 1;
      
      # Enable WiFi power saving
      WIFI_PWR_ON_BAT = "on";
    };
  };
  
  # Enable auto-cpufreq
  services.auto-cpufreq.enable = true;
  
  # Enable thermald
  services.thermald.enable = true;
}
```

### Suspend/Hibernate Configuration

```nix
{
  # Enable suspend and hibernate
  powerManagement.enable = true;
  
  # Configure resume device
  boot.resumeDevice = "/dev/disk/by-uuid/your-swap-uuid";
  
  # Hibernate support
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=2h
    SuspendState=mem disk
  '';
}
```

## 🎯 Hardware Detection

### Automatic Detection Script

```bash
#!/bin/bash
# hardware-detect.sh

echo "=== Hardware Detection ==="
echo

# CPU
echo "CPU Information:"
lscpu | grep "Model name\|Architecture\|CPU(s)"
echo

# GPU
echo "GPU Information:"
lspci | grep -i vga
echo

# Memory
echo "Memory Information:"
free -h
echo

# Storage
echo "Storage Devices:"
lsblk -d -o name,size,model
echo

# Network
echo "Network Devices:"
lspci | grep -i network
echo

# USB Devices
echo "USB Devices:"
lsusb | head -10
echo

# Audio
echo "Audio Devices:"
aplay -l
echo
```

### NixOS Hardware Configuration

```nix
{
  # Auto-generate hardware configuration
  # Run: sudo nixos-generate-config
  
  imports = [
    ./hardware-configuration.nix
  ];
  
  # Enable common hardware support
  hardware = {
    # Enable Bluetooth
    bluetooth.enable = true;
    
    # Enable OpenGL
    opengl.enable = true;
    
    # Enable pulse audio
    pulseaudio.enable = true;
    
    # Enable firmware loading
    enableRedistributableFirmware = true;
  };
}
```

## 🔍 Troubleshooting Hardware

### Common Issues

#### GPU Not Detected
```bash
# Check GPU detection
lspci | grep -i vga
nvidia-smi  # NVIDIA
radeontop    # AMD
intel_gpu_top # Intel
```

#### Audio Not Working
```bash
# Check audio devices
aplay -l
arecord -l

# Restart audio services
systemctl --user restart pipewire
systemctl --user restart pipewire-pulse
```

#### WiFi Not Working
```bash
# Check WiFi adapter
lspci | grep -i network
lsusb | grep -i wireless

# Restart NetworkManager
sudo systemctl restart NetworkManager
```

### Hardware Compatibility Check

```bash
# Check hardware compatibility with NixOS
nix-hardware-scan

# Generate hardware report
nixos-generate-config --show-hardware-config
```

## 📚 Additional Resources

- [NixOS Hardware Wiki](https://wiki.nixos.org/wiki/Hardware)
- [NixOS GPU Support](https://wiki.nixos.org/wiki/Nvidia)
- [NixOS Audio Configuration](https://wiki.nixos.org/wiki/PulseAudio)

---

**📖 Next:** Check [User Management](users.md) for user configuration.
