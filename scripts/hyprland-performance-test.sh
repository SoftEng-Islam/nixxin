#!/usr/bin/env bash

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║              Hyprland Performance Testing Script                          ║
# ║          For AMD Ryzen 5 3400G APU (Vega 11 Graphics)                    ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║       Hyprland Performance Test - AMD APU Edition             ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to print section headers
print_section() {
    echo ""
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  $1${NC}"
    echo -e "${MAGENTA}═══════════════════════════════════════════════════════════════${NC}"
}

# Function to check command existence
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}✗${NC} $1 not found"
        return 1
    else
        echo -e "${GREEN}✓${NC} $1 found"
        return 0
    fi
}

# Check if Hyprland is running
print_section "System Check"
if ! pgrep -x Hyprland > /dev/null; then
    echo -e "${RED}✗ Hyprland is not running!${NC}"
    exit 1
else
    echo -e "${GREEN}✓ Hyprland is running${NC}"
fi

# Check for required tools
check_command "hyprctl" || exit 1
check_command "jq" || echo -e "${YELLOW}⚠ jq not found - some tests will be skipped${NC}"

# Get Hyprland version
print_section "Hyprland Information"
HYPR_VERSION=$(hyprctl version | head -n 1)
echo -e "${CYAN}Version:${NC} $HYPR_VERSION"

# Get active monitor info
print_section "Monitor Information"
if command -v jq &> /dev/null; then
    hyprctl monitors -j | jq -r '.[] | "Monitor: \(.name)\nResolution: \(.width)x\(.height)@\(.refreshRate)Hz\nScale: \(.scale)\nVRR: \(.vrr)\n"'
else
    hyprctl monitors
fi

# Check environment variables
print_section "Environment Variables (AMD Optimizations)"
env_vars=(
    "XDG_CURRENT_DESKTOP"
    "XDG_SESSION_TYPE"
    "WLR_RENDERER"
    "WLR_NO_HARDWARE_CURSORS"
    "RADV_PERFTEST"
    "AMD_VULKAN_ICD"
)

for var in "${env_vars[@]}"; do
    value=$(printenv "$var" 2>/dev/null || echo "NOT SET")
    if [ "$value" = "NOT SET" ]; then
        echo -e "${RED}✗${NC} $var: ${RED}$value${NC}"
    else
        echo -e "${GREEN}✓${NC} $var: ${GREEN}$value${NC}"
    fi
done

# Check loaded plugins
print_section "Loaded Plugins"
if hyprctl plugin list 2>/dev/null | grep -q "Plugin"; then
    hyprctl plugin list | grep -E "(Plugin|Author|Description)" || echo "No plugins loaded"
else
    echo "No plugins loaded or plugin system not available"
fi

# Check current settings
print_section "Performance Settings"

# Animations
echo -e "${CYAN}Animations:${NC}"
hyprctl getoption animations:enabled | grep -E "int:|set to" | awk '{print $NF}'

# Blur
echo -e "${CYAN}Blur:${NC}"
hyprctl getoption decoration:blur:enabled 2>/dev/null | grep -E "int:|set to" | awk '{print $NF}' || echo "Check manually"
hyprctl getoption decoration:blur:size 2>/dev/null | grep -E "int:|set to" | awk '{print "  Size:", $NF}' || true
hyprctl getoption decoration:blur:passes 2>/dev/null | grep -E "int:|set to" | awk '{print "  Passes:", $NF}' || true

# Shadow
echo -e "${CYAN}Shadow:${NC}"
hyprctl getoption decoration:shadow:enabled 2>/dev/null | grep -E "int:|set to" | awk '{print $NF}' || echo "Check manually"
hyprctl getoption decoration:shadow:range 2>/dev/null | grep -E "int:|set to" | awk '{print "  Range:", $NF}' || true

# VRR
echo -e "${CYAN}VRR (Variable Refresh Rate):${NC}"
hyprctl getoption misc:vrr 2>/dev/null | grep -E "int:|set to" | awk '{print $NF, "(0=off, 1=on, 2=fullscreen)"}' || echo "Check manually"

# Direct scanout
echo -e "${CYAN}Direct Scanout:${NC}"
hyprctl getoption render:direct_scanout 2>/dev/null | grep -E "int:|set to" | awk '{print $NF}' || echo "Check manually"

# GPU Info
print_section "AMD GPU Information"
if [ -d "/sys/class/drm/card0/device" ]; then
    echo -e "${CYAN}GPU:${NC}"
    cat /sys/class/drm/card0/device/uevent 2>/dev/null | grep -E "PCI_ID|PCI_SUBSYS_ID" || echo "GPU info not available"

    echo ""
    echo -e "${CYAN}Current GPU Clocks:${NC}"
    if [ -f "/sys/class/drm/card0/device/pp_dpm_sclk" ]; then
        grep "\*" /sys/class/drm/card0/device/pp_dpm_sclk || echo "Clock info not available"
    else
        echo "Clock monitoring not available"
    fi

    echo ""
    echo -e "${CYAN}GPU Memory Info:${NC}"
    if [ -f "/sys/class/drm/card0/device/mem_info_vram_used" ]; then
        vram_used=$(cat /sys/class/drm/card0/device/mem_info_vram_used 2>/dev/null || echo "0")
        vram_total=$(cat /sys/class/drm/card0/device/mem_info_vram_total 2>/dev/null || echo "0")
        if [ "$vram_total" -gt 0 ]; then
            vram_used_mb=$((vram_used / 1024 / 1024))
            vram_total_mb=$((vram_total / 1024 / 1024))
            echo "  VRAM: ${vram_used_mb}MB / ${vram_total_mb}MB"
        fi
    else
        echo "  VRAM info not available"
    fi
fi

# Performance recommendations
print_section "Quick Performance Tips"
echo -e "${YELLOW}For MAXIMUM FPS (gaming):${NC}"
echo "  1. Disable blur: modules.desktop.hyprland.blur.enable = false"
echo "  2. Disable shadows: modules.desktop.hyprland.shadow.enable = false"
echo "  3. Set animation speed to fast"
echo "  4. Use 'immediate' window rule for games"
echo ""
echo -e "${GREEN}Current setup is BALANCED for daily use with good performance${NC}"
echo ""
echo -e "${CYAN}Test different settings and rebuild:${NC}"
echo "  sudo nixos-rebuild switch --flake .#yourhostname"

print_section "Test Complete!"
echo ""
echo -e "${GREEN}✓ All checks completed${NC}"
echo -e "${CYAN}Save this output for comparison after changes${NC}"
echo ""
