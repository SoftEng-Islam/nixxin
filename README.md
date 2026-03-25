# Nixxin

**NixOS** Enhancement Configurations

> [!NOTE]
>
> This project is now ready for use by others! See the [Setup Guide](./SETUP.md) for installation instructions.

This repository contains a modular NixOS configuration that can be easily customized for different users and hardware setups.

## 🚀 Quick Start

1. **Clone the repo:**

   ```bash
   git clone https://github.com/SoftEng-Islam/nixxin.git ~/.config/nixxin
   cd ~/.config/nixxin
   ```

2. **Copy the template:**

   ```bash
   cp -r users/template/users/YOUR_USERNAME
   cp _settings.template.nix _settings.nix
   ```

3. **Edit your configuration:**

   ```bash
   nano users/YOUR_USERNAME/desktop/YOUR_HOSTNAME/default.nix
   nano _settings.nix
   ```

4. **Apply:**

   ```bash
   sudo nixos-rebuild switch --flake .#YOUR_HOSTNAME
   ```

## 📚 Documentation

- [**Setup Guide**](./SETUP.md) - Complete installation and configuration instructions
- [**Module Overview**](./documentation/) - Detailed documentation for each module
- [**Troubleshooting**](./SETUP.md#troubleshooting) - Common issues and solutions

## ✨ Features

- **Modular Design** - Enable/disable modules as needed
- **Hardware Agnostic** - Works with Intel, AMD, and NVIDIA systems
- **Easy Customization** - Simple configuration options
- **Pre-configured Modules** - Development, gaming, office, media, and more
- **Home Manager Integration** - User-level configuration management

## 🏗️ Module Structure

```
modules/
├── development/     # Development tools and environments
├── desktop/         # Desktop environment and window managers
├── browsers/       # Web browsers
├── media/          # Audio/video applications
├── gaming/         # Gaming platforms and tools
├── office/         # Office applications
├── system/         # System-level configuration
├── networking/     # Network configuration
├── security/       # Security settings
└── ...             # And many more!
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](./LICENSE).

## 🆘 Support

- **Issues:** [GitHub Issues](https://github.com/SoftEng-Islam/nixxin/issues)
- **Discussions:** [GitHub Discussions](https://github.com/SoftEng-Islam/nixxin/discussions)
- **NixOS Manual:** [nixos.org/manual](https://nixos.org/manual/nixos/stable/)

---

**Note:** This configuration is designed to be a starting point. You may need to adjust hardware-specific settings based on your system.
