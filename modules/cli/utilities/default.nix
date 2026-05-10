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
  utilities = settings.modules.cli.utilities;
  _imports = [
    (optional utilities.aider-chat ./aider-chat.nix)
    (optional utilities.atuin ./atuin.nix)
    (optional utilities.charm ./charm.nix)
    (optional utilities.claude-code ./claude-code.nix)
    (optional utilities.eza ./eza.nix)
    (optional utilities.fzf ./fzf.nix)
    (optional utilities.glow ./glow.nix)
    (optional utilities.gnused ./gnused.nix)
    (optional utilities.gpg ./gpg.nix)
    (optional utilities.grep ./grep.nix)
    (optional utilities.jujutsu ./jujutsu.nix)
    (optional utilities.nh ./nh.nix)
    (optional utilities.nurl ./nurl.nix)
    (optional utilities.ripgrep ./ripgrep.nix)
    (optional utilities.ssh ./ssh.nix)
    (optional utilities.zoxide ./zoxide.nix)
    (optional utilities.bat ./bat.nix)
    (optional utilities.direnv ./direnv.nix)
    (optional utilities.fd ./fd.nix)
    (optional utilities.lf ./lf.nix)
  ];

in
{
  imports = flatten _imports;
  config = mkIf (utilities.enable or false) {
    environment.systemPackages = with pkgs; [
      shellcheck
    ];
  };
}
