{ settings, ... }: {
  home-manager = {
    # extraSpecialArgs = { inherit inputs; };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = settings.home.backupFileExtension; # null
  };

  home-manager.users.${settings.users.user1.username} = {
    programs.home-manager.enable = true;
    home = {
      username = settings.users.user1.username;
      homeDirectory = "/home/${settings.users.user1.username}";
      stateVersion = settings.homeStateVersion;
      sessionPath = [ "$HOME/.local/bin" ];
    };
    manual = {
      # You can Disable manuals as nmd fails to build often
      html.enable = true;
      json.enable = true;
      manpages.enable = true;
    };
  };
}
