{ self, inputs, settings, ... }: {
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ home-manager ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  home-manager = {
    # extraSpecialArgs = {
    #   inherit inputs;
    #   inherit settings;
    #   inherit self;
    # };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = null; # null
  };

  home-manager.users.${settings.users.user1.username} = {
    programs.home-manager.enable = true;
    home = {
      username = settings.users.user1.username;
      homeDirectory = "/home/${settings.users.user1.username}";
      stateVersion = settings.homeStateVersion;
      # sessionVariables = {};
      sessionPath = [ "$HOME/.local/bin" ];
    };
    manual = {
      # disable manuals as nmd fails to build often
      html.enable = true;
      json.enable = true;
      manpages.enable = true;
    };
  };
}
