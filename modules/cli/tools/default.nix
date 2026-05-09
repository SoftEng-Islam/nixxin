{
  settings,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    optional
    flatten
    ;
  tools = settings.modules.cli.tools;
  _imports = [
    (optional tools.charm ./charm.nix)
    (optional tools.claude-code ./claude-code.nix)
    (optional tools.eza ./eza.nix)
    (optional tools.fzf ./fzf.nix)
    (optional tools.glow ./glow.nix)
    (optional tools.gnused ./gnused.nix)
    (optional tools.grep ./grep.nix)
    (optional tools.jujutsu ./jujutsu.nix)
    (optional tools.nh ./nh.nix)
    (optional tools.nurl ./nurl.nix)
    (optional tools.ripgrep ./ripgrep.nix)
    (optional tools.zoxide ./zoxide.nix)
  ];

in
{
  imports = flatten _imports;
  config = mkIf (tools.enable or false) {
    environment.systemPackages = with pkgs; [
      shellcheck
    ];
  };
}
