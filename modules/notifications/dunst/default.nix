# https://dunst-project.org/
{ settings, pkgs, ... }:
let
  dunst-toggle-mode = pkgs.writeScriptBin "dunst-toggle-mode"
    (builtins.readFile ./scripts/dunst-toggle-mode.sh);
in {
  environment.systemPackages = with pkgs; [ dunst dunst-toggle-mode libnotify ];

  # nixpkgs.overlays = [ (final: prev: { _custom = pkgs.callPackage ./dunst-nctui { }; }) ];

  # programs.dunst.enable = true;
  home-manager.users."${settings.user.username}" = {
    home.file.".config/dunst/dunstrc".source = ./dunstrc;
  };
}
