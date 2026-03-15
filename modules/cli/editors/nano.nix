{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      nanorc # Improved Nano Syntax Highlighting Files
    ];
}
