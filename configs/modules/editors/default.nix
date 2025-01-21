{ settings, pkgs, ... }: {
  imports = [
    # ./eclipse.nix
    # ./helix.nix
    ./vscode.nix
    # ./zed-editor.nix
  ];
}
