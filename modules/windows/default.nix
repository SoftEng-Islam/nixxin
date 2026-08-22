{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
mkIf (settings.modules.windows.enable or false) {
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
    wine        # 32+64-bit Windows app compatibility
    winetricks  # Install DLLs and components
    winePackages.fonts  # Microsoft-compatible fonts
    cifs-utils  # SMB/Windows share mounting

    # Removed (install manually if needed):
    # wine64           — included in wine's wineWow64 build
    # winePackages.stableFull — huge 32-bit Wine stack, only needed for legacy apps
    # wineasio / yabridge / yabridgectl — VST audio bridge (niche, very large)
  ];
}
