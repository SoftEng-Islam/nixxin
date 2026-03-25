# Nixxin Setup Guide

## Quick Start for New Users

### Prerequisites
- NixOS installed on your system
- Basic understanding of Nix/NixOS
- Git installed

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/SoftEng-Islam/nixxin.git ~/.config/nixxin
   cd ~/.config/nixxin
   ```

2. **Create your user profile:**
   ```bash
   # Copy the template to your username
   cp -r users/template users/YOUR_USERNAME
   
   # Edit the configuration
   nano users/YOUR_USERNAME/desktop/YOUR_HOSTNAME/default.nix
   ```

3. **Update settings path:**
   ```bash
   # Edit _settings.nix to point to your profile
   nano _settings.nix
   # Change: path = "/users/template/desktop/template";
   # To: path = "/users/YOUR_USERNAME/desktop/YOUR_HOSTNAME";
   ```

4. **Apply configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#YOUR_HOSTNAME
   ```

## Configuration Options

### Required Changes in Your Profile

Edit `users/YOUR_USERNAME/desktop/YOUR_HOSTNAME/default.nix`:

1. **User Information:**
   ```nix
   user.name = "Your Name";           # Your display name
   user.username = "yourusername";    # Your system username
   user.email = "your@email.com";     # Your email
   ```

2. **System Information:**
   ```nix
   system.hostName = "yourhostname";  # Your system hostname
   system.architecture = "x86_64-linux"; # Your architecture
   ```

3. **Hardware Configuration:**
   ```nix
   # CPU settings - adjust based on your hardware
   common.cpu.intel = true;          # Set true if Intel CPU
   common.cpu.amd = false;            # Set true if AMD CPU
   common.cpu.nvidiaGPU = false;     # Set true if NVIDIA GPU
   common.cpu.intelGPU = false;      # Set true if Intel GPU
   common.cpu.amdGPU = true;         # Set true if AMD GPU
   ```

### Module Customization

Enable/disable modules in your profile:

```nix
# Enable/disable entire modules
modules.development.enable = true;
modules.gaming.enable = false;
modules.bluetooth.enable = true;

# Configure specific module options
modules.browsers.firefox.enable = true;
modules.browsers.chrome.enable = false;
```

## Hardware-Specific Configurations

### AMD GPU Users
Keep the AMD-specific kernel parameters and modules in the template.

### Intel GPU Users
Remove AMD-specific configurations and add Intel equivalents.

### NVIDIA GPU Users
Add NVIDIA drivers and remove AMD/Intel GPU configurations.

## Troubleshooting

### Common Issues

1. **Build fails with user-specific paths:**
   - Ensure `_settings.nix` points to your user profile
   - Check that all paths exist in your configuration

2. **Hardware issues:**
   - Review kernel parameters for your hardware
   - Check GPU driver configurations

3. **Module conflicts:**
   - Disable conflicting modules
   - Check module dependencies

### Getting Help

- Check the [GitHub Issues](https://github.com/SoftEng-Islam/nixxin/issues)
- Read the [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- Join the NixOS community forums

## Contributing

To contribute back to the project:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Advanced Usage

### Custom Modules

Create your own modules in the `modules/` directory:

```nix
# modules/my-module/default.nix
{ pkgs, config, lib, ... }:
{
  options.my-module.enable = lib.mkEnableOption "My Module";
  
  config = lib.mkIf config.my-module.enable {
    # Your configuration here
  };
}
```

### Overlays

Add custom packages via overlays in your flake:

```nix
# In flake.nix outputs
nixosConfigurations = {
  hostname = nixpkgs.lib.nixosSystem {
    # ... existing config ...
    modules = [
      # ... existing modules ...
      ({
        nixpkgs.overlays = [
          (final: prev: {
            my-package = final.callPackage ./pkgs/my-package { };
          })
        ];
      })
    ];
  };
};
```
