# Contributing to Nixxin 🚀

Thank you for your interest in contributing to Nixxin! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### 🐛 Reporting Issues

- Use the [GitHub Issues](https://github.com/SoftEng-Islam/nixxin/issues) page
- Search existing issues before creating a new one
- Provide detailed information about your issue
- Include your system specifications (NixOS version, hardware, etc.)
- Add relevant logs and error messages

### 💡 Feature Requests

- Open an issue with the "enhancement" label
- Describe the feature you'd like to see
- Explain why it would be useful
- Suggest how it could be implemented

### 🔧 Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/nixxin.git
   cd nixxin
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add comments where necessary
   - Test your changes thoroughly

4. **Commit your changes**
   ```bash
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Provide a clear description of your changes
   - Reference any relevant issues
   - Include screenshots if applicable

## 📝 Development Guidelines

### Code Style

- Use Nix formatting tools
- Follow the existing module structure
- Keep configurations modular and reusable
- Add comments for complex configurations

### Module Structure

```
modules/category/module-name/
├── default.nix          # Main module file
├── options.nix         # Module options (if complex)
├── config.nix         # Configuration logic (if complex)
└── README.md          # Module documentation (optional)
```

### Testing

- Test your changes on a clean system
- Verify that all modules work as expected
- Check for conflicts with existing configurations
- Test on different hardware if applicable

## 🎯 Areas for Contribution

### High Priority

- **Documentation improvements**
- **Bug fixes**
- **Hardware compatibility**
- **Performance optimizations**

### Medium Priority

- **New modules**
- **Theme improvements**
- **Setup script enhancements**
- **Testing automation**

### Low Priority

- **Code refactoring**
- **Feature enhancements**
- **Integration improvements**

## 🏗️ Module Development

### Creating a New Module

1. Create the module directory:
   ```bash
   mkdir modules/category/new-module
   ```

2. Create the main module file:
   ```nix
   { pkgs, config, lib, ... }:
   let
     inherit (lib) mkEnableOption mkIf;
   in
   {
     options.modules.category.new-module.enable = mkEnableOption "New Module";
     
     config = mkIf config.modules.category.new-module.enable {
       # Your configuration here
     };
   }
   ```

3. Add to user configuration:
   ```nix
   modules.category.new-module.enable = true;
   ```

### Module Guidelines

- Make modules configurable with boolean flags
- Provide sensible defaults
- Document all options
- Handle dependencies properly
- Test on multiple systems

## 📸 Adding Screenshots

When adding visual changes:

1. Take screenshots of your changes
2. Add them to the `assets/` directory
3. Update the README with new screenshots
4. Use descriptive filenames

## 🌐 Community

### Getting Help

- Join our [GitHub Discussions](https://github.com/SoftEng-Islam/nixxin/discussions)
- Check existing issues and pull requests
- Ask questions in the discussions tab

### Spreading the Word

- Star the repository ⭐
- Share with friends and colleagues
- Write blog posts or tutorials
- Present at meetups or conferences

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the same [MIT License](LICENSE) as the project.

## 🙏 Recognition

Contributors will be recognized in:

- The README.md contributors section
- Release notes for significant contributions
- Special mentions in project announcements

---

Thank you for contributing to Nixxin! Your help makes this project better for everyone. 🚀
