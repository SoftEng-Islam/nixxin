{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;

  obsidian-wrapped = pkgs.runCommand "obsidian-wrapped" {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.obsidian}/bin/obsidian $out/bin/obsidian \
      --add-flags "--disable-gpu-sandbox" \
      --add-flags "--use-gl=desktop" \
      --add-flags "--enable-features=UseOzonePlatform" \
      --add-flags "--ozone-platform=x11" \
      --add-flags "--enable-wayland-ime"

    # Export app icons into the profile so launchers can resolve `Icon=obsidian`.
    mkdir -p $out/share/icons
    cp -r ${pkgs.obsidian}/share/icons/. $out/share/icons/
  '';
in mkIf (settings.modules.office.obsidian or false) {
  environment.systemPackages = [
    # Powerful knowledge base that works on top of a local folder of plain text Markdown files
    obsidian-wrapped
  ];
  home-manager.users.${settings.user.username} = {
    xdg.desktopEntries.obsidian = {
      name = "Obsidian";
      genericName = "Note-taking App";
      comment = "Markdown-based note-taking with GPU workarounds";
      exec = "${obsidian-wrapped}/bin/obsidian %U";
      icon = "obsidian"; # or path to a custom icon
      terminal = false;
      type = "Application";
      categories = [ "Office" "Utility" ];
    };
  };
}
