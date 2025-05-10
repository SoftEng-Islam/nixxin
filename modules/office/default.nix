{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;

  _pkgs = [
    # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    (optionals settings.modules.office.obsidian
      (pkgs.writeShellScriptBin "obsidian-fixed" ''
        exec ${pkgs.obsidian}/bin/obsidian \
          --disable-gpu-sandbox \
          --use-gl=desktop \
          --enable-features=UseOzonePlatform \
          --ozone-platform=x11 \
          "$@"
      ''))
    # Privacy-first personal knowledge management system that supports complete offline usage, as well as end-to-end encrypted data sync
    (optionals settings.modules.office.siyuan pkgs.siyuan)
  ];
in {
  imports = optionals (settings.modules.office.enable or false) [
    ./documents.nix
    ./libreoffice.nix
  ];
  config = mkIf (settings.modules.office.enable or false) {
    environment.systemPackages = lib.flatten _pkgs;
  };
  environment.variables = { "OBSIDIAN_USE_SOFTWARE_RENDERER" = "1"; };
}
