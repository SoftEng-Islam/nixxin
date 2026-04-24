#!/bin/bash

# 🔐 Nixxin Secrets Setup Script
# This script helps you set up secure secrets management

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "${BLUE}🔐 $1${NC}"
    echo "----------------------------------------"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Main setup function
main() {
    print_header "Nixxin Secrets Setup"
    
    # Check if we're in the right directory
    if [[ ! -f "default.nix" ]]; then
        print_error "Please run this script from the secrets/ directory"
        exit 1
    fi
    
    # Create personal secrets file
    if [[ -f "secrets.nix" ]]; then
        print_warning "secrets.nix already exists!"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Skipping secrets.nix creation"
        else
            create_secrets_file
        fi
    else
        create_secrets_file
    fi
    
    # Set up git ignore
    setup_gitignore
    
    # Set permissions
    set_permissions
    
    # Install secret management tools
    install_tools
    
    # Generate SSH keys if needed
    setup_ssh
    
    # Create backup script
    create_backup_script
    
    print_success "Secrets setup complete!"
    echo
    print_info "Next steps:"
    echo "1. Edit secrets/secrets.nix with your actual information"
    echo "2. Test your configuration with: nixos-rebuild build"
    echo "3. Read secrets/README.md for best practices"
}

create_secrets_file() {
    print_header "Creating Personal Secrets File"
    
    # Get user information
    echo -e "${BLUE}Please enter your information:${NC}"
    
    read -p "Full name: " USER_NAME
    read -p "Username: " USER_USERNAME
    read -p "Email: " USER_EMAIL
    read -p "Timezone (default: America/New_York): " USER_TIMEZONE
    USER_TIMEZONE=${USER_TIMEZONE:-"America/New_York"}
    
    # Create secrets file with user information
    cat > secrets.nix << EOF
# 🔐 Personal Secrets Configuration
# Generated on $(date)
# IMPORTANT: Never commit this file to version control!

{
  # 📧 Email Configuration
  email = {
    user = "${USER_EMAIL}";
  };

  # 👤 User Information
  user = {
    name = "${USER_NAME}";
    username = "${USER_USERNAME}";
    description = "Nixxin User";
  };

  # 🔑 API Keys and Tokens
  apiKeys = {
    # GitHub Personal Access Token
    github = "";
    
    # OpenAI API Key
    openai = "";
    
    # Anthropic API Key
    anthropic = "";
  };

  # 🌍 Localization
  localization = {
    timezone = "${USER_TIMEZONE}";
    locale = "en_US.UTF-8";
    keyboard = "us";
  };

  # 🎨 Theme Configuration
  theme = {
    gtk = "Adwaita-dark";
    qt = "Adwaita-dark";
    terminal = "Catppuccin-Mocha";
    wallpaper = "/home/${USER_USERNAME}/Pictures/Wallpapers/default.jpg";
  };

  # 🤖 AI Services
  ai = {
    ollama = {
      baseUrl = "http://localhost:11434";
      models = ["llama2" "codellama"];
    };
    
    claude = {
      apiKey = "";
      model = "claude-3-sonnet";
    };
  };

  # 🔧 Development Tools
  development = {
    dockerHub = "";
    npm = "";
    pypi = "";
    
    ssh = {
      github = "~/.ssh/github_key";
      gitlab = "~/.ssh/gitlab_key";
    };
  };

  # 🏠 Home Services
  services = {
    jellyfin = "";
    plex = "";
    
    nextcloud = {
      url = "";
      username = "";
      password = "";
    };
  };

  # 🌐 Network Configuration
  network = {
    wifi = {
      # "Network-SSID" = "password";
    };
    
    vpn = {
      provider = "";
      username = "";
      password = "";
    };
  };

  # 📊 Monitoring and Analytics
  monitoring = {
    prometheus = {
      apiKey = "";
      endpoint = "";
    };
    
    grafana = {
      apiKey = "";
      url = "";
    };
  };
}
EOF
    
    print_success "Created secrets.nix with your information"
    print_info "Please edit secrets.nix to add your API keys and other sensitive data"
}

setup_gitignore() {
    print_header "Setting Up Git Ignore"
    
    # Check if parent directory has git
    if [[ -d "../.git" ]]; then
        if ! grep -q "secrets/secrets.nix" ../.gitignore; then
            echo "secrets/secrets.nix" >> ../.gitignore
            print_success "Added secrets/secrets.nix to .gitignore"
        else
            print_info "secrets/secrets.nix already in .gitignore"
        fi
    else
        print_warning "Not in a git repository, skipping .gitignore setup"
    fi
}

set_permissions() {
    print_header "Setting File Permissions"
    
    # Set restrictive permissions
    chmod 600 secrets.nix
    chmod 700 .
    
    print_success "Set restrictive permissions on secrets files"
}

install_tools() {
    print_header "Installing Secret Management Tools"
    
    # Check if nix is available
    if command -v nix-env &> /dev/null; then
        echo "Installing secret management tools..."
        
        # Install age for encryption
        if ! command -v age &> /dev/null; then
            nix-env -iA nixpkgs.age
            print_success "Installed age for encryption"
        else
            print_info "age already installed"
        fi
        
        # Install sops
        if ! command -v sops &> /dev/null; then
            nix-env -iA nixpkgs.sops
            print_success "Installed sops for secrets management"
        else
            print_info "sops already installed"
        fi
        
        # Install jq for JSON processing
        if ! command -v jq &> /dev/null; then
            nix-env -iA nixpkgs.jq
            print_success "Installed jq for JSON processing"
        else
            print_info "jq already installed"
        fi
    else
        print_warning "nix-env not found, skipping tool installation"
        print_info "Please install tools manually: age, sops, jq"
    fi
}

setup_ssh() {
    print_header "Setting Up SSH Keys"
    
    if [[ ! -f ~/.ssh/id_ed25519 ]]; then
        print_info "Generating SSH key..."
        ssh-keygen -t ed25519 -C "${USER_EMAIL}" -f ~/.ssh/id_ed25519 -N ""
        
        print_success "Generated SSH key"
        print_info "Add this SSH key to your accounts:"
        cat ~/.ssh/id_ed25519.pub
        echo
    else
        print_info "SSH key already exists"
    fi
}

create_backup_script() {
    print_header "Creating Backup Script"
    
    cat > backup-secrets.sh << 'EOF'
#!/bin/bash

# 🔐 Backup Secrets Script
# This script creates encrypted backups of your secrets

set -euo pipefail

SECRETS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/nixxin-secrets-backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="secrets-backup-${TIMESTAMP}.tar.gz.age"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create encrypted backup
echo "Creating encrypted backup..."
tar -czf - "$SECRETS_DIR/secrets.nix" | age -r "$(cat ~/.ssh/id_ed25519.pub)" > "$BACKUP_DIR/$BACKUP_FILE"

echo "Backup created: $BACKUP_DIR/$BACKUP_FILE"
echo "To restore: age -d -i ~/.ssh/id_ed25519 $BACKUP_DIR/$BACKUP_FILE | tar -xzf -"

# Clean old backups (keep last 5)
cd "$BACKUP_DIR"
ls -t secrets-backup-*.tar.gz.age | tail -n +6 | xargs -r rm

echo "Backup complete!"
EOF

    chmod +x backup-secrets.sh
    print_success "Created backup-secrets.sh"
}

# Error handling
trap 'print_error "Script failed at line $LINENO"' ERR

# Run main function
main "$@"
