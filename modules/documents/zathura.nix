{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;

in mkIf (settings.modules.documents) {
  home-manager.users."${settings.user.username}" = {
    # You code
  };
  environment.systemPackages = with pkgs;
    [
      # athura is a highly customizable and functional PDF viewer based on the poppler rendering library and the GTK toolkit.
      zathura
    ];
}
