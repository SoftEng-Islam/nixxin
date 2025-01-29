{ settings, ... }: {
  home-manager = {
    # extraSpecialArgs = { inherit inputs; };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = settings.home.backupFileExtension; # null
  };

  home-manager.users.${settings.users.selected.username} = {
    programs.home-manager.enable = true;
    home = {
      username = settings.users.selected.username;
      homeDirectory = "/home/${settings.users.selected.username}";
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
