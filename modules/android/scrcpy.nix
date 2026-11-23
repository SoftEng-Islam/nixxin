{
  settings,
  lib,
  pkgs,
  ...
}:
lib.mkIf (settings.modules.android.scrcpy.enable or false) {
  nixpkgs.overlays = [
    (_final: prev: {
      scrcpy = prev.symlinkJoin {
        name = "scrcpy";
        paths = [ prev.scrcpy ];
        nativeBuildInputs = [ prev.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/scrcpy \
            --add-flags "--turn-screen-off --stay-awake --power-off-on-close --max-size 1024 --video-bit-rate 4M"
        '';
      };
    })
  ];

  environment.systemPackages = [ pkgs.scrcpy ]; # picks up the overlay
}
