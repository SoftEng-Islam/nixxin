{ settings, pkgs, ... }: {
  # Enable DXVK in Wine:
  # WINEPREFIX=~/.wine winecfg
  # Go to the Libraries tab, add d3d11 and dxgi, and set them to "native."
  # Optional: Enable 32-bit Wine for older games
  # Add this if you want a 32-bit Wine prefix:
  environment.variables = {
    WINEPREFIX = "/home/${settings.username}/.wine";
    WINEARCH = "win32"; # Set Wine architecture to 32-bit
  };
  environment.systemPackages = with pkgs; [
    # Modern and transparent way to use Windows VST2 and VST3 plugins on Linux
    # yabridge
    # yabridgectl

    directx-headers # Official D3D12 headers from Microsoft
    wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    wine64 # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    wineasio # ASIO to JACK driver for WINE
    winePackages.fonts # Microsoft replacement fonts by the Wine project
    winePackages.stable # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    winetricks # A script to install DLLs needed to work around problems in Wine
    wineWowPackages.waylandFull # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    libGL # GL Vendor-Neutral Dispatch library
    libGLU # OpenGL utility library
    #libGLX # GL Vendor-Neutral Dispatch library
    vulkan-loader # LunarG Vulkan loader
    vkd3d-proton # A fork of VKD3D, which aims to implement the full Direct3D 12 API on top of Vulkan
    vkd3d # Direct3D to Vulkan translation library
  ];
}
