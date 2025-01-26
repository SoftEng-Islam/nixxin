{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vscode ];
  imports = [
    # ./eclipse.nix
    # ./helix.nix
    # ./vscode.nix
    ./zed-editor.nix
  ];
}
