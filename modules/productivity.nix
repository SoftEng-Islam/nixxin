{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      # hugo # static site generator
      # glow # markdown previewer in terminal
      # graphviz # Graph visualization tools
    ];
}
