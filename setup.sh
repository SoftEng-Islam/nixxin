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
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

to_nix_bool() {
    if [[ "$1" =~ ^[Yy]$ ]]; then
        echo true
    else
        echo false
    fi
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
    
    INTEL_CPU_BOOL="$(to_nix_bool "$INTEL_CPU")"
    AMD_CPU_BOOL="$(to_nix_bool "$AMD_CPU")"
    NVIDIA_GPU_BOOL="$(to_nix_bool "$NVIDIA_GPU")"
    AMD_GPU_BOOL="$(to_nix_bool "$AMD_GPU")"
    INTEL_GPU_BOOL="$(to_nix_bool "$INTEL_GPU")"
    IS_LAPTOP_BOOL="$(to_nix_bool "$IS_LAPTOP")"
    CPU_ARCH="amd64"

    if [[ "$ARCHITECTURE" == aarch64-* ]]; then
        CPU_ARCH="aarch64"
    fi

    # Create user directory structure
    USER_DIR="$REPO_DIR/users/$USERNAME"
    
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
    
    cat > "$USER_DIR/default.nix" <<EOF
{
  ...
}:
self:
{
  user.name = "$USER_NAME";
  user.username = "$USERNAME";
  user.email = "$EMAIL";

  system.hostName = "$HOSTNAME";
  system.architecture = "$ARCHITECTURE";

  common.cpu.arch = "$CPU_ARCH";
  common.cpu.intel = $INTEL_CPU_BOOL;
  common.cpu.amd = $AMD_CPU_BOOL;
  common.cpu.zen = $AMD_CPU_BOOL;
  common.cpu.ryzen = $AMD_CPU_BOOL;
  common.cpu.ryzenMobile = false;
  common.cpu.nvidiaGPU = $NVIDIA_GPU_BOOL;
  common.cpu.amdGPU = $AMD_GPU_BOOL;
  common.cpu.intelGPU = $INTEL_GPU_BOOL;
  common.battery = $IS_LAPTOP_BOOL;
}
EOF
    print_success "Created users/$USERNAME/default.nix"

    if [[ -f /etc/nixos/hardware-configuration.nix ]]; then
        cp /etc/nixos/hardware-configuration.nix "$USER_DIR/hardware.nix"
        print_success "Copied /etc/nixos/hardware-configuration.nix"
    else
        cat > "$USER_DIR/hardware.nix" <<'EOF'
{ ... }:
{
  # Replace this file with your generated hardware-configuration.nix.
}
EOF
        print_warning "Created a placeholder hardware.nix because /etc/nixos/hardware-configuration.nix was not found"
    fi
    
    # Update _settings.nix
    SETTINGS_FILE="$REPO_DIR/_settings.nix"
    if [[ -f "$SETTINGS_FILE" ]]; then
        cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
        print_warning "Backed up existing _settings.nix"
    fi

    if grep -q 'activeUser = "' "$SETTINGS_FILE" 2>/dev/null; then
        sed -i -E "s/activeUser = \".*\";/activeUser = \"$USERNAME\";/" "$SETTINGS_FILE"
    else
        cat > "$SETTINGS_FILE" <<EOF
{
  lib,
  pkgs ? null,
  ...
}:
let
  activeUser = "$USERNAME";
  userDir = ./. + "/users/\${activeUser}";
  userModule = userDir + "/default.nix";
  hardwareModule = userDir + "/hardware.nix";
  userOverrides = import userModule { inherit pkgs; };
  bootstrapProfile = lib.fix (self: userOverrides self);
in
{
  inherit activeUser;
  architecture = bootstrapProfile.system.architecture or "x86_64-linux";

  selectedUser = {
    name = activeUser;
    path = "/users/\${activeUser}";
    dir = userDir;
    inherit userModule hardwareModule;
  };

  profile =
    if pkgs == null then
      null
    else
      let
        schema = import ./users/schema/default.nix { inherit pkgs; };
      in
      lib.fix (self: lib.recursiveUpdate (schema self) (userOverrides self));
}
EOF
    fi
    print_success "Selected $USERNAME as the active user in _settings.nix"
    
    echo
    print_header "Setup Complete!"
    
    echo -e "${GREEN}Your Nixxin configuration has been set up!${NC}"
    echo
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Review your configuration:"
    echo "   ${BLUE}nano $USER_DIR/default.nix${NC}"
    echo
    echo "2. Apply the configuration:"
    echo "   ${BLUE}cd $REPO_DIR${NC}"
    echo "   ${BLUE}sudo nixos-rebuild switch --flake .#$HOSTNAME${NC}"
    echo
    echo "3. For troubleshooting, see:"
    echo "   ${BLUE}nano /home/$USERNAME/nixxin/SETUP.md${NC}"
    echo
    print_success "Happy NixOS configuring!"
}

# Run main function
main "$@"
