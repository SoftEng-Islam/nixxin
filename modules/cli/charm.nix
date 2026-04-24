{pkgs, ...}: {
  home.packages = with pkgs; [
    gum
    vhs
    pop
    mods
  ];
}
