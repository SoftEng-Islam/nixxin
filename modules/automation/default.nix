{ settings, pkgs, ... }:
{
  imports = [
    ./n8n.nix
  ];
  environment.systemPackages = with pkgs; [
    uv
    (pkgs.writeShellScriptBin "browser-use" ''
      exec ${pkgs.uv}/bin/uvx browser-use[cli] "$@"
    '')
  ];
}
