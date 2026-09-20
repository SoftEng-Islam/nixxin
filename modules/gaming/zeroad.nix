{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.gaming.zeroad.enable or false) {
  environment.systemPackages = with pkgs; [
    (zeroad.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
      postFixup = (oldAttrs.postFixup or "") + ''
        wrapProgram $out/bin/pyrogenesis \
          --set SDL_VIDEODRIVER x11 \
          --prefix LD_LIBRARY_PATH : ${
            lib.makeLibraryPath [
              vulkan-loader # libvulkan.so
              vulkan-validation-layers # validation layer runtime
              pipewire
              sqlite
              mesa
              mesa_i686
              libGL
              libGLU
              libglvnd
            ]
          } \
          --set LD_PRELOAD "${pkgs.vulkan-loader}/lib/libvulkan.so.1"
      '';
    }))
    # pkgs.zeroadPackages.zeroad-data
  ];
  home-manager.users.${settings.user.username} = {
    xdg.desktopEntries.zeroad = {
      name = "0 A.D.";
      genericName = "Real-Time Strategy Game";
      comment = "A free, open-source real-time strategy game";
      exec = "env SDL_VIDEODRIVER=x11 ${pkgs.zeroad}/bin/0ad %U";
      icon = "0ad";
      terminal = false;
      type = "Application";
      categories = [
        "Game"
        "StrategyGame"
      ];
    };
  };
}
