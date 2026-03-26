# 🚀 Installation

This guide will walk you through installing Nixxin on your NixOS system.

## 📋 Prerequisites

Before you begin, make sure you have:

- A working NixOS installation
- `sudo` access on your system
- Internet connection
- Git installed

## ⚡ Quick Installation

### Method 1: Automated Setup (Recommended)

```bash
# Clone the repository
git clone https://github.com/SoftEng-Islam/nixxin.git ~/.config/nixxin
cd ~/.config/nixxin

# Run the setup script
./setup.sh

# Apply configuration
sudo nixos-rebuild switch --flake .#YOUR_HOSTNAME
```

The setup script will:
- Detect your hardware
- Configure user settings
- Set up appropriate modules
- Generate configuration files

### Method 2: Manual Installation

If you prefer manual setup:

```bash
# 1. Clone the repository
git clone https://github.com/SoftEng-Islam/nixxin.git ~/.config/nixxin
cd ~/.config/nixxin

# 2. Copy example configuration
cp examples/basic.nix configuration.nix

# 3. Edit configuration
nano configuration.nix

# 4. Build and switch
sudo nixos-rebuild switch --flake .
```

## 🔧 System Requirements

### Minimum Requirements
- **RAM:** 4GB
- **Storage:** 20GB free space
- **CPU:** x86_64 compatible

### Recommended Requirements
- **RAM:** 8GB or more
- **Storage:** 50GB free space
- **CPU:** Modern multi-core processor

### Supported Hardware
- **CPU:** Intel, AMD (including Ryzen)
- **GPU:** Intel HD, AMD Radeon, NVIDIA
- **Architecture:** x86_64 (ARM64 experimental)

## 📦 Installation Steps

### Step 1: Prepare Your System

```bash
# Update your system
sudo nixos-rebuild switch --upgrade

# Install Git (if not already installed)
sudo nixos-rebuild switch --install git
```

### Step 2: Clone Nixxin

```bash
# Create config directory
mkdir -p ~/.config

# Clone the repository
git clone https://github.com/SoftEng-Islam/nixxin.git ~/.config/nixxin
cd ~/.config/nixxin
```

### Step 3: Run Setup Script

```bash
# Make setup script executable
chmod +x setup.sh

# Run the interactive setup
./setup.sh
```

The setup script will ask for:
- Your full name
- Username
- Email address
- Hostname
- System architecture
- Hardware details (CPU, GPU, etc.)

### Step 4: Apply Configuration

```bash
# Build and switch to new configuration
sudo nixos-rebuild switch --flake .#YOUR_HOSTNAME
```

### Step 5: Reboot

```bash
# Reboot to apply all changes
sudo reboot
```

## 🎯 Verification

After installation, verify everything is working:

```bash
# Check Nixxin status
nixxin status

# List enabled modules
nixxin list-modules

# Check system health
nixxin health-check
```

## 🔄 Updating Nixxin

To update your Nixxin configuration:

```bash
# Go to your config directory
cd ~/.config/nixxin

# Pull latest changes
git pull origin main

# Update and rebuild
sudo nixos-rebuild switch --flake .#YOUR_HOSTNAME
```

## 🗑️ Uninstallation

If you need to remove Nixxin:

```bash
# Backup current configuration
sudo cp /etc/nixos/configuration.nix ~/configuration.nix.backup

# Remove Nixxin directory
rm -rf ~/.config/nixxin

# Restore backup configuration
sudo cp ~/configuration.nix.backup /etc/nixos/configuration.nix

# Rebuild with original config
sudo nixos-rebuild switch
```

## 🆘 Troubleshooting

### Common Issues

#### Permission Denied
```bash
# Ensure proper permissions
sudo chown -R $USER:$USER ~/.config/nixxin
chmod +x setup.sh
```

#### Build Failures
```bash
# Check for syntax errors
nix-instantiate --eval configuration.nix

# Clean and rebuild
sudo nixos-rebuild switch --upgrade
```

#### Hardware Detection Issues
```bash
# Check hardware info
lscpu
lspci
lsusb

# Manually specify hardware in configuration
```

### Getting Help

- Check the [Troubleshooting Guide](../advanced/troubleshooting.md)
- Open an [Issue on GitHub](https://github.com/SoftEng-Islam/nixxin/issues)
- Join our [Discussions](https://github.com/SoftEng-Islam/nixxin/discussions)

---

**🎉 Congratulations! You now have Nixxin installed on your system!**

Next: [Quick Start Guide](quick-start.md)
