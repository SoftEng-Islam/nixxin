{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
mkIf (settings.modules.windows.enable) {
  # Enable DXVK in Wine:
  # WINEPREFIX=~/.wine winecfg
  # Go to the Libraries tab, add d3d11 and dxgi, and set them to "native."

  environment.variables = {
    # Optional: Enable 32-bit Wine for older games
    # Add this if you want a 32-bit Wine prefix
    # WINEPREFIX = "/home/${settings.user.username}/.wine";
    # WINEARCH = "win32"; # Set Wine architecture to 32-bit

    WINE_GALLIUM_NINE = "1";

    # Optimize Wine performance.
    WINEESYNC = "1";
    WINEFSYNC = "1";
  };

  home-manager.users."${settings.user.username}" = {
    xdg.desktopEntries.wine = {
      name = "Wine Windows Program Loader";
      exec = "wine %f";
      terminal = false;
      mimeType = [ "application/x-ms-dos-executable" ];
      noDisplay = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Modern and transparent way to use Windows VST2 and VST3 plugins on Linux
    yabridge
    yabridgectl
    cifs-utils
    # directx-headers # Official D3D12 headers from Microsoft
    wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    wine64 # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    wineasio # ASIO to JACK driver for WINE
    winePackages.fonts # Microsoft replacement fonts by the Wine project
    winePackages.stableFull # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    winetricks # A script to install DLLs needed to work around problems in Wine

    # wineWowPackages.waylandFull # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    # libGL # GL Vendor-Neutral Dispatch library
    # libGLU # OpenGL utility library
    # vulkan-loader # LunarG Vulkan loader
    # vkd3d-proton # A fork of VKD3D, which aims to implement the full Direct3D 12 API on top of Vulkan
    # vkd3d # Direct3D to Vulkan translation library
  ];
}
