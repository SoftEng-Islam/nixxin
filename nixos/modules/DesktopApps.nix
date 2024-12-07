{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zoom-us
    ferdium
    slack
    inkscape
    mumble
    signal-desktop

    gimp
  ];
}
