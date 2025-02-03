{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode-fhs
    vscodium-fhs
    gnome-text-editor
  ];
  imports = [
    ./eclipse.nix
    ./helix.nix
    # ./vscode.nix
    # ./zed-editor.nix
  ];
}
