{ pkgs, ... }: {
  #__ Graphic Applications __#
  environment.systemPackages = with pkgs; [
    lunacy # Free design software that keeps your flow with AI tools and built-in graphics
    drawio # A desktop application for creating diagrams
    inkscape # Vector graphics editor
    gimp # GNU Image Manipulation Program
    blender-hip # 3D Creation/Animation/Publishing System
    # figma-linux

  ];
}
