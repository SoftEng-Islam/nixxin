{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.black
    python3Packages.flake8
    python3Packages.ipython
  ];
}
