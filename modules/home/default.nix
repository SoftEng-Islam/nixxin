{ settings, lib, pkgs, ... }: {
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
      stateVersion = settings.modules.home.stateVersion;
    };
    manual = {
      # You can Disable manuals as nmd fails to build often
      html.enable = settings.modules.home.manual.html;
      json.enable = settings.modules.home.manual.json;
      manpages.enable = settings.modules.home.manual.manpages;
    };
  };
  environment.systemPackages = with pkgs; [ home-manager ];
}
