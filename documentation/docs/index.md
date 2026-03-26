# 🚀 Nixxin Documentation

<div align="center">

**NixOS** Enhancement Configurations

[![Stars](https://img.shields.io/github/stars/SoftEng-Islam/nixxin?style=social)](https://github.com/SoftEng-Islam/nixxin/stargazers)
[![Forks](https://img.shields.io/github/forks/SoftEng-Islam/nixxin?style=social)](https://github.com/SoftEng-Islam/nixxin/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modular, feature-rich NixOS configuration that's easy to customize for different users and hardware setups.

</div>

## 🎯 What is Nixxin?

Nixxin is a comprehensive NixOS configuration framework designed to make system management simple, modular, and reproducible. Whether you're a beginner looking for an easy setup or an advanced user wanting full control, Nixxin provides the perfect balance.

## ✨ Key Features

- **🔧 Modular Design** - Enable/disable modules with simple boolean flags
- **💻 Hardware Agnostic** - Works with Intel, AMD, and NVIDIA systems
- **⚡ Easy Customization** - Simple configuration options for all skill levels
- **📦 Pre-configured Modules** - Development, gaming, office, media, and more
- **🏠 Home Manager Integration** - Seamless user-level configuration management
- **🎨 Beautiful Themes** - Pre-configured GTK, QT, and terminal themes
- **🛡️ Security Focused** - Hardened configurations and best practices

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/SoftEng-Islam/nixxin.git ~/.config/nixxin
cd ~/.config/nixxin

# Run the setup script
./setup.sh

# Apply configuration
sudo nixos-rebuild switch --flake .#YOUR_HOSTNAME
```

### Basic Configuration

```nix
{
  description = "Nixxin Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations = {
      your-hostname = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
```

## 📚 Documentation Structure

!!! info "Navigation"
    Use the sidebar on the left to navigate through different sections of the documentation.

### **Getting Started**

New to Nixxin? Start here for installation and basic configuration.

### **Modules**

Explore all available modules and their configuration options.

### **Configuration**

Learn about hardware support, user management, and customization.

### **Advanced**

Dive deep into custom modules, flake management, and troubleshooting.

### **Examples**

Ready-to-use configurations for different use cases.

## 🎮 Try Before You Install

Want to see what Nixxin can do without installing?

```bash
curl -sSL https://raw.githubusercontent.com/SoftEng-Islam/nixxin/main/demo.sh | bash
```

## 🤝 Contributing

We welcome contributions of all kinds! Check out our [Contributing Guide](../contributing/guidelines.md) for detailed instructions.

## 🆘 Support

- **Issues:** [GitHub Issues](https://github.com/SoftEng-Islam/nixxin/issues)
- **Discussions:** [GitHub Discussions](https://github.com/SoftEng-Islam/nixxin/discussions)
- **Documentation:** [You're here!](.)

---

**🚀 Ready to transform your NixOS experience?**

[**⭐ Star on GitHub**](https://github.com/SoftEng-Islam/nixxin) • [**📚 Explore Modules**](modules/overview.md) • [**🎮 Try Demo**](https://raw.githubusercontent.com/SoftEng-Islam/nixxin/main/demo.sh)
