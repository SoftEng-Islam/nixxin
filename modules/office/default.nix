{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;

  _pkgs = with pkgs; [
    # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    (optionals settings.modules.office.obsidian
      (pkgs.writeShellScriptBin "obsidian" ''
        exec ${pkgs.obsidian}/bin/obsidian \
          --disable-gpu-sandbox \
          --use-gl=desktop \
          --enable-features=UseOzonePlatform \
          --ozone-platform=x11 \
          "$@"
      ''))
    # (optionals settings.modules.office.obsidian obsidian)
    # Privacy-first personal knowledge management system that supports complete offline usage, as well as end-to-end encrypted data sync
    (optionals settings.modules.office.siyuan siyuan)
  ];
in {
  imports = optionals (settings.modules.office.enable or false) [
    ./documents.nix
    ./libreoffice.nix
  ];
  config = mkIf (settings.modules.office.enable or false) {
    environment.systemPackages = lib.flatten _pkgs;
    home-manager.users.${settings.user.username} = {
      xdg.desktopEntries.obsidian = {
        name = "Obsidian";
        genericName = "Note-taking App";
        comment = "Markdown-based note-taking with GPU workarounds";
        exec = "obsidian %U";
        icon = "obsidian"; # or path to a custom icon
        terminal = false;
        type = "Application";
        categories = [ "Office" "Utility" ];
      };
    };
  };
}
