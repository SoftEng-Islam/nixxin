{ settings, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in mkIf (settings.modules.office.obsidian or true) {
  environment.systemPackages = with pkgs;
    [
      # Powerful knowledge base that works on top of a local folder of plain text Markdown files
      (writeShellScriptBin "obsidian" ''
        exec ${pkgs.obsidian}/bin/obsidian \
          --disable-gpu-sandbox \
          --use-gl=desktop \
          --enable-features=UseOzonePlatform \
          --ozone-platform=x11 \
          --enable-wayland-ime \
          "$@"
      '')
      # --ozone-platform=wayland \
      # (optionals settings.modules.office.obsidian obsidian)
      # Privacy-first personal knowledge management system that supports complete offline usage, as well as end-to-end encrypted data sync
      # obsidian
    ];
  home-manager.users.${settings.user.username} = {
    home.packages = [
      # (pkgs.writeShellScriptBin "obsidian" ''
      #   exec ${pkgs.obsidian}/bin/obsidian \
      #     --disable-gpu-sandbox \
      #     --use-gl=desktop \
      #     --enable-features=UseOzonePlatform \
      #     --ozone-platform=x11 \
      #     "$@"
      # '')
    ];
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
}
