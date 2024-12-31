{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # required by personal nvim config
    statix # nvim-lint
    nixfmt-classic # conform.nvim
    nixd # lsp server
  ];
}
