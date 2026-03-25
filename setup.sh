#!/bin/bash

# Nixxin Setup Script
# This script helps new users set up their Nixxin configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Get user input with default value
get_input() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    echo -e "${YELLOW}$prompt${NC}"
    echo -e "Default: ${GREEN}$default${NC}"
    read -p "> " input
    
    if [[ -z "$input" ]]; then
        input="$default"
    fi
    
    eval "$var_name='$input'"
}

# Check if running as root for system operations
check_sudo() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root for user configuration steps."
        exit 1
    fi
}

# Main setup function
main() {
    print_header "Nixxin Setup Script"
    
    check_sudo
    
    echo -e "${BLUE}This script will help you set up your Nixxin configuration.${NC}"
    echo -e "${YELLOW}Please answer the following questions:${NC}"
    echo
    
    # Get user information
    get_input "What is your full name?" "User Name" "USER_NAME"
    get_input "What is your username (for system login)?" "$(whoami)" "USERNAME"
    get_input "What is your email?" "user@example.com" "EMAIL"
    get_input "What is your hostname?" "nixos" "HOSTNAME"
    get_input "What is your system architecture?" "x86_64-linux" "ARCHITECTURE"
    
    echo
    print_header "Hardware Configuration"
    
    # CPU configuration
    echo -e "${YELLOW}CPU Configuration:${NC}"
    get_input "Do you have an Intel CPU? (y/n)" "n" "INTEL_CPU"
    get_input "Do you have an AMD CPU? (y/n)" "y" "AMD_CPU"
    
    # GPU configuration
    echo
    echo -e "${YELLOW}GPU Configuration:${NC}"
    get_input "Do you have an NVIDIA GPU? (y/n)" "n" "NVIDIA_GPU"
    get_input "Do you have an AMD GPU? (y/n)" "y" "AMD_GPU"
    get_input "Do you have an Intel GPU? (y/n)" "n" "INTEL_GPU"
    
    # Laptop detection
    echo
    get_input "Is this a laptop (has battery)? (y/n)" "n" "IS_LAPTOP"
    
    echo
    print_header "Creating Your Configuration"
    
    # Create user directory structure
    USER_DIR="/home/$USERNAME/nixxin/users/$USERNAME/desktop/$HOSTNAME"
    
    if [[ -d "$USER_DIR" ]]; then
        print_warning "Configuration directory already exists: $USER_DIR"
        read -p "Do you want to overwrite it? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Setup cancelled."
            exit 1
        fi
        rm -rf "$USER_DIR"
    fi
    
    # Create directories
    mkdir -p "$USER_DIR"
    print_success "Created directory: $USER_DIR"
    
    # Copy template configuration
    cp "/home/$USERNAME/nixxin/users/template/desktop/template/default.nix" "$USER_DIR/default.nix"
    print_success "Copied template configuration"
    
    # Update configuration with user data
    sed -i "s/Your Name/$USER_NAME/g" "$USER_DIR/default.nix"
    sed -i "s/yourusername/$USERNAME/g" "$USER_DIR/default.nix"
    sed -i "s/your@email.com/$EMAIL/g" "$USER_DIR/default.nix"
    sed -i "s/nixos/$HOSTNAME/g" "$USER_DIR/default.nix"
    sed -i "s/x86_64-linux/$ARCHITECTURE/g" "$USER_DIR/default.nix"
    
    # Update CPU settings
    if [[ "$INTEL_CPU" =~ ^[Yy]$ ]]; then
        sed -i 's/common\.cpu\.intel = false;/common.cpu.intel = true;/g' "$USER_DIR/default.nix"
    fi
    if [[ "$AMD_CPU" =~ ^[Yy]$ ]]; then
        sed -i 's/common\.cpu\.amd = true;/common.cpu.amd = true;/g' "$USER_DIR/default.nix"
    else
        sed -i 's/common\.cpu\.amd = true;/common.cpu.amd = false;/g' "$USER_DIR/default.nix"
    fi
    
    # Update GPU settings
    if [[ "$NVIDIA_GPU" =~ ^[Yy]$ ]]; then
        sed -i 's/common\.cpu\.nvidiaGPU = false;/common.cpu.nvidiaGPU = true;/g' "$USER_DIR/default.nix"
        sed -i 's/common\.cpu\.amdGPU = true;/common.cpu.amdGPU = false;/g' "$USER_DIR/default.nix"
        sed -i 's/amdgpu/nvidia/g' "$USER_DIR/default.nix"
    elif [[ "$INTEL_GPU" =~ ^[Yy]$ ]]; then
        sed -i 's/common\.cpu\.intelGPU = false;/common.cpu.intelGPU = true;/g' "$USER_DIR/default.nix"
        sed -i 's/common\.cpu\.amdGPU = true;/common.cpu.amdGPU = false;/g' "$USER_DIR/default.nix"
        sed -i 's/amdgpu/intel/g' "$USER_DIR/default.nix"
    fi
    
    # Update battery setting
    if [[ "$IS_LAPTOP" =~ ^[Yy]$ ]]; then
        sed -i 's/common\.battery = false;/common.battery = true;/g' "$USER_DIR/default.nix"
    fi
    
    print_success "Updated configuration with your settings"
    
    # Update _settings.nix
    SETTINGS_FILE="/home/$USERNAME/nixxin/_settings.nix"
    if [[ -f "$SETTINGS_FILE" ]]; then
        cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
        print_warning "Backed up existing _settings.nix"
    fi
    
    cp "/home/$USERNAME/nixxin/_settings.template.nix" "$SETTINGS_FILE"
    sed -i "s|/users/template/desktop/template|/users/$USERNAME/desktop/$HOSTNAME|g" "$SETTINGS_FILE"
    print_success "Updated _settings.nix"
    
    echo
    print_header "Setup Complete!"
    
    echo -e "${GREEN}Your Nixxin configuration has been set up!${NC}"
    echo
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Review your configuration:"
    echo "   ${BLUE}nano $USER_DIR/default.nix${NC}"
    echo
    echo "2. Apply the configuration:"
    echo "   ${BLUE}cd /home/$USERNAME/nixxin${NC}"
    echo "   ${BLUE}sudo nixos-rebuild switch --flake .#$HOSTNAME${NC}"
    echo
    echo "3. For troubleshooting, see:"
    echo "   ${BLUE}nano /home/$USERNAME/nixxin/SETUP.md${NC}"
    echo
    print_success "Happy NixOS configuring!"
}

# Run main function
main "$@"
