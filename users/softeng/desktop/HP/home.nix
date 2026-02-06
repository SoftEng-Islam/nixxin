{ settings, lib, pkgs, ... }: {
  home-manager = {
    # extraSpecialArgs = { inherit inputs; };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = settings.home.backupFileExtension; # null
  };
  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    # xdg.configFile."mimeapps.list".force = true
    home = {
      username = settings.user.username;
      homeDirectory = "/home/${settings.user.username}";
      stateVersion = settings.home.stateVersion;
    };
    manual = {
      # You can Disable manuals as nmd fails to build often
      html.enable = settings.home.manual.html;
      json.enable = settings.home.manual.json;
      manpages.enable = settings.home.manual.manpages;
    };
  };
  environment.systemPackages = with pkgs; [ home-manager ];
}
