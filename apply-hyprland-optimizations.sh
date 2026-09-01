#!/usr/bin/env bash

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║           Apply Hyprland Performance Optimizations                        ║
# ║                    Quick Rebuild Helper                                   ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     Hyprland Performance Optimizations - Rebuild Script       ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if running in the correct directory
if [ ! -f "flake.nix" ]; then
    echo -e "${RED}✗ Error: flake.nix not found!${NC}"
    echo -e "${YELLOW}Please run this script from your NixOS configuration directory${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found flake.nix${NC}"
echo ""

# Display what will be applied
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  Performance Optimizations to be Applied:${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}✓${NC} Animation durations reduced by ~15-20%"
echo -e "${GREEN}✓${NC} Shadow range optimized (15 → 12)"
echo -e "${GREEN}✓${NC} Gap spacing reduced (better screen usage)"
echo -e "${GREEN}✓${NC} Only essential plugins enabled"
echo -e "${GREEN}✓${NC} AMD RADV optimizations active"
echo -e "${GREEN}✓${NC} Blur kept at optimal settings (size=3, passes=1)"
echo ""

# Run pre-rebuild test if script exists
if [ -f "scripts/hyprland-performance-test.sh" ]; then
    echo -e "${YELLOW}Would you like to save current performance metrics? (y/N)${NC}"
    read -r -n 1 response
    echo ""
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}Saving current metrics...${NC}"
        ./scripts/hyprland-performance-test.sh > /tmp/hyprland-before-optimization.txt 2>&1 || true
        echo -e "${GREEN}✓ Saved to /tmp/hyprland-before-optimization.txt${NC}"
        echo ""
    fi
fi

# Ask for confirmation
echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}Ready to rebuild NixOS with optimizations?${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "This will run: ${CYAN}sudo nixos-rebuild switch --flake .#${NC}"
echo ""
echo -e "${YELLOW}Continue? (y/N)${NC}"
read -r -n 1 response
echo ""

if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Cancelled by user${NC}"
    exit 0
fi

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}  Building NixOS Configuration...${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

# Determine hostname if not provided
if [ -z "${1:-}" ]; then
    HOSTNAME=$(hostname)
    echo -e "${YELLOW}No hostname provided, using current: ${CYAN}${HOSTNAME}${NC}"
    echo ""
fi

# Run the rebuild
if sudo nixos-rebuild switch --flake ".#${1:-$HOSTNAME}"; then
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              ✓ Rebuild Successful!                            ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}What's changed:${NC}"
    echo -e "  • Faster animations (15-20% shorter durations)"
    echo -e "  • Optimized shadows (reduced range)"
    echo -e "  • Better screen space usage (reduced gaps)"
    echo -e "  • AMD GPU optimizations active"
    echo ""

    # Offer to run post-rebuild test
    if [ -f "scripts/hyprland-performance-test.sh" ]; then
        echo -e "${YELLOW}Would you like to test the new configuration? (y/N)${NC}"
        read -r -n 1 response
        echo ""
        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo -e "${CYAN}Running performance test...${NC}"
            echo ""
            ./scripts/hyprland-performance-test.sh
            echo ""
            if [ -f "/tmp/hyprland-before-optimization.txt" ]; then
                echo -e "${CYAN}Compare before/after:${NC}"
                echo -e "  Before: /tmp/hyprland-before-optimization.txt"
                echo -e "  After:  Run test again and save output"
            fi
        fi
    fi

    echo ""
    echo -e "${GREEN}Next steps:${NC}"
    echo -e "  1. Log out and back in (or reload Hyprland: ${CYAN}hyprctl reload${NC})"
    echo -e "  2. Test window animations and overall responsiveness"
    echo -e "  3. Run: ${CYAN}./scripts/hyprland-performance-test.sh${NC} to verify settings"
    echo ""
    echo -e "${YELLOW}Note: If Hyprland is currently running, reload it:${NC}"
    echo -e "  ${CYAN}hyprctl reload${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║              ✗ Rebuild Failed!                                ║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Check the error messages above for details.${NC}"
    echo -e "${YELLOW}You may need to fix syntax errors or missing dependencies.${NC}"
    echo ""
    exit 1
fi
