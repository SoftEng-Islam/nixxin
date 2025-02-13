{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  home-manager = {
    # extraSpecialArgs = { inherit inputs; };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = settings.modules.home.backupFileExtension; # null
  };
  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    home = {
      username = settings.user.username;
      homeDirectory = "/home/${settings.user.username}";
      stateVersion = settings.home.stateVersion;
    };
    manual = {
      # You can Disable manuals as nmd fails to build often
      html.enable = true;
      json.enable = true;
      manpages.enable = true;
    };
  };
}
