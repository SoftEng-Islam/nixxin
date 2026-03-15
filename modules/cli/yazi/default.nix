{
  pkgs,
  config,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    package = pkgs.yazi;
    settings = builtins.fromTOML (builtins.readFile ./dotfiles/yazi.toml);
    keymap = builtins.fromTOML (builtins.readFile ./dotfiles/keymap.toml);
    theme = import ./theme.nix;
    flavors = import ./flavors.nix {inherit pkgs;};
    plugins = import ./plugins.nix {inherit pkgs;};
    shellWrapperName = "y";
  };
}
