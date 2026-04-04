{ pkgs, ... }:

{
  environment.systemPackages = [
    # AI Tools for developers
    pkgs.update.code-cursor
    (pkgs.symlinkJoin {
      name = "antigravity";
      paths = [ pkgs.update.antigravity ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/antigravity \
          --unset NIXOS_OZONE_WL \
          --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations"
      '';
    })
    pkgs.update.windsurf
  ];
}
