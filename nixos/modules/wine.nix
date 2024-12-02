{ pkgs, ... }:
{
  # Enable DXVK in Wine:
  # WINEPREFIX=~/.wine winecfg
  # Go to the Libraries tab, add d3d11 and dxgi, and set them to "native."

  environment.systemPackages = with pkgs; [
    # wine64 # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    directx-headers # Official D3D12 headers from Microsoft
    wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    wineasio # ASIO to JACK driver for WINE
    winePackages.fonts
    winePackages.stableFull
    winetricks # A script to install DLLs needed to work around problems in Wine
    wineWowPackages.waylandFull
    libGL # GL Vendor-Neutral Dispatch library
    libGLU # OpenGL utility library
    vulkan-loader # LunarG Vulkan loader
    vkd3d-proton # A fork of VKD3D, which aims to implement the full Direct3D 12 API on top of Vulkan
  ];
}
