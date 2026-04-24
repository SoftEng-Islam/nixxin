{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      micro # Modern and intuitive terminal-based text editor
    ];
}
