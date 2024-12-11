{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    grim # Grab images from a Wayland compositor
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    flameshot # Powerful yet simple to use screenshot software
    scrot # A command-line screen capture utility
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

  ];
}
