{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fish fish-lsp ];
}
