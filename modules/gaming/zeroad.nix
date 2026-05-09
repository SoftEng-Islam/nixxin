{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.gaming.zeroad.enable or false) {
  environment.systemPackages = with pkgs; [
    # 0 A.D. with Vulkan support
    (pkgs.update.zeroad.overrideAttrs {
      postFixup = ''
        wrapProgram $out/bin/haruna \
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
    })
    pkgs.update.zeroad-data
  ];
}
