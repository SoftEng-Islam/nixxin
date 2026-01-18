echo $XDG_SESSION_TYPE
echo $XDG_CURRENT_DESKTOP
echo $AMD_VULKAN_ICD
echo $VK_LOADER_DISABLE_LAYER_MESA
echo $VK_LAYER_PATH
echo $VK_LOADER_LAYERS_DISABLE

# Useful Commands
vulkan-helper physical-versions
vulkan-helper instance-version
vulkan-helper nvapi-path
export RUST_BACKTRACE=full && vulkan-helper nvapi-path
