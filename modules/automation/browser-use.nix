{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    uv
    (pkgs.writeShellScriptBin "browser-use" ''
      exec ${pkgs.uv}/bin/uvx browser-use[cli] "$@"
    '')
  ];
}
