{ settings, pkgs, ... }: {
  # ---- Graphics Apps ----#
  environment.systemPackages = with pkgs; [

    # Free design software that keeps your flow with AI tools and built-in graphics
    (if settings.features.graphics.lunacy then lunacy else "")

    # Unofficial Electron-based Figma desktop app for Linux
    (if settings.features.graphics.figmaLinux then figma-linux else "")

    # A desktop application for creating diagrams
    (if settings.features.graphics.drawio then drawio else "")

    # 3D Creation/Animation/Publishing System
    (if settings.features.graphics.blender then blender-hip else "")

    # GNU Image Manipulation Program
    (if settings.features.graphics.gimp then gimp else "")

    # Vector graphics editor
    (if settings.features.graphics.inkscape then inkscape else "")

    # Virtual lighttable and darkroom for photographers
    (if settings.features.graphics.darktable then darktable else "")
  ];
}
