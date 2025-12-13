{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.icons.enable or true) {
  nixpkgs.overlays = [
    (final: prev: {
      # ------------------------------
      # Papirus folder color override
      # ------------------------------
      papirus-icon-theme = prev.papirus-icon-theme.overrideAttrs (old: {
        fixupPhase = ''
          # settings
          # black, blue, brown, cyan, green, grey, indigo, magenta, orange, pink, purple, red, teal, white, yellow
          color=${settings.common.icons.folder-color}
          THEME_DIR=$out/share/icons/Papirus

          # see change_color
          sizes=(22x22 24x24 32x32 48x48 64x64)
          prefixes=("folder-$color" "user-$color")

          for size in "''${sizes[@]}"; do
            for prefix in "''${prefixes[@]}"; do
              for file_path in "$THEME_DIR/$size/places/$prefix"{-*,}.svg; do
                [ -f "$file_path" ] || continue  # skip if not a file
                [ -L "$file_path" ] && continue  # skip if symlink

                file_name="''${file_path##*/}"
                symlink_path="''${file_path/-$color/}"  # remove color suffix

                ln -sf "$file_name" "$symlink_path" || {
                  echo "Failed to create '$symlink_path'"
                }
              done
            done
          done
        '';
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    icon-library # Symbolic icons for your apps
    papirus-icon-theme
    adwaita-icon-theme
  ];
}
