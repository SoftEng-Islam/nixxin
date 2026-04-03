#!/bin/bash

# Nixxin Demo Script - Showcases the configuration features
# This script demonstrates the key features of Nixxin for potential users

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Animation
spinner() {
    local chars="/-\|"
    for (( i=0; i<10; i++ )); do
        for (( j=0; j<${#chars}; j++ )); do
            sleep 0.1
            printf "\r${CYAN}Loading ${chars:$j:1}${NC}"
        done
    done
    printf "\r${GREEN}✓ Done!${NC}\n"
}

print_header() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                                                              ║"
    echo "║                    🚀 NIXXIN DEMO 🚀                         ║"
    echo "║                                                              ║"
    echo "║          Modular NixOS Configuration System                  ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo
}

print_section() {
    echo -e "${PURPLE}═══ $1 ═══${NC}"
    echo
}

print_feature() {
    echo -e "${YELLOW}✨ $1${NC}"
    echo -e "   $2"
    echo
}

show_module_demo() {
    local module=$1
    local description=$2
    local features=$3
    
    echo -e "${CYAN}📦 Module: $module${NC}"
    echo -e "${GREEN}   📝 $description${NC}"
    echo -e "${YELLOW}   🔧 Features: $features${NC}"
    echo
}

show_command_demo() {
    local command=$1
    local description=$2
    
    echo -e "${BLUE}💻 Command:${NC}"
    echo -e "${GREEN}   $command${NC}"
    echo -e "${YELLOW}   📋 $description${NC}"
    echo
}

main() {
    print_header
    
    echo -e "${CYAN}Welcome to the Nixxin Configuration Demo!${NC}"
    echo -e "${YELLOW}This demo showcases the powerful features of Nixxin...${NC}"
    echo
    sleep 2
    
    print_section "🎯 KEY FEATURES"
    
    print_feature "Modular Design" \
        "Enable/disable modules with simple boolean flags. No complex setup required!"
    
    print_feature "Hardware Agnostic" \
        "Works with Intel, AMD, and NVIDIA systems out of the box."
    
    print_feature "One-Click Setup" \
        "Get started in minutes with our automated setup script."
    
    print_feature "Beautiful Themes" \
        "Pre-configured GTK, QT, and terminal themes included."
    
    sleep 3
    print_section "📦 MODULE SHOWCASE"
    
    show_module_demo "Desktop Environment" \
        "Modern desktop environments with Hyprland, GNOME tools" \
        "Wayland support, window management, themes"
    
    show_module_demo "Development" \
        "Complete development setup with VSCode, Helix, Emacs" \
        "Multiple languages, tools, extensions"
    
    show_module_demo "Gaming" \
        "Gaming platforms and tools for all your gaming needs" \
        "Steam, Lutris, Wine, optimizations"
    
    show_module_demo "Security" \
        "Hardened configurations and security best practices" \
        "Firewall, hardening, privacy tools"
    
    sleep 3
    print_section "⚡ QUICK COMMANDS"
    
    show_command_demo "./setup.sh" \
        "Interactive setup script for new users"
    
    show_command_demo "sudo nixos-rebuild switch --flake .#hostname" \
        "Apply your configuration changes"
    
    show_command_demo "mkdir -p users/yourname && \$EDITOR users/yourname/default.nix" \
        "Create your personal configuration"
    
    sleep 3
    print_section "🎨 THEMES & CUSTOMIZATION"
    
    print_feature "GTK Themes" \
        "Beautiful themes like Adwaita, Colloid, Dracula"
    
    print_feature "Terminal Themes" \
        "Pre-configured terminal with powerline, fonts, colors"
    
    print_feature "Icon Themes" \
        "Papirus icons with multiple color variants"
    
    sleep 3
    print_section "🛡️ SECURITY FEATURES"
    
    print_feature "Firewall Configuration" \
        "Pre-configured nftables firewall"
    
    print_feature "System Hardening" \
        "Security best practices applied"
    
    print_feature "Privacy Protection" \
        "Privacy-focused configurations"
    
    sleep 3
    print_section "🚀 GETTING STARTED"
    
    echo -e "${GREEN}Step 1: Clone the repository${NC}"
    echo -e "${BLUE}   git clone https://github.com/SoftEng-Islam/nixxin.git${NC}"
    echo
    
    echo -e "${GREEN}Step 2: Run the setup script${NC}"
    echo -e "${BLUE}   cd nixxin && ./setup.sh${NC}"
    echo
    
    echo -e "${GREEN}Step 3: Apply configuration${NC}"
    echo -e "${BLUE}   sudo nixos-rebuild switch --flake .#hostname${NC}"
    echo
    
    sleep 3
    print_section "🌟 COMMUNITY & SUPPORT"
    
    print_feature "GitHub Stars" \
        "Star the repository to show your support!"
    
    print_feature "Contributions Welcome" \
        "Join our community and contribute to the project"
    
    print_feature "Issues & Discussions" \
        "Get help and share your experiences"
    
    sleep 3
    print_section "🎉 DEMO COMPLETE"
    
    echo -e "${GREEN}Thank you for trying the Nixxin Demo!${NC}"
    echo
    echo -e "${YELLOW}Ready to get started?${NC}"
    echo -e "${BLUE}🌐 Visit: https://github.com/SoftEng-Islam/nixxin${NC}"
    echo -e "${BLUE}📚 Documentation: https://github.com/SoftEng-Islam/nixxin/blob/main/SETUP.md${NC}"
    echo -e "${BLUE}⭐ Star us on GitHub!${NC}"
    echo
    
    echo -e "${PURPLE}═══ Thank you for trying Nixxin! ═══${NC}"
    echo
}

# Run the demo
main "$@"
