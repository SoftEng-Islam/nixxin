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

  home-manager.users.${settings.username} = {
    programs.home-manager.enable = true;

    programs.bat.enable = true;
    programs.eza.enable = true;
    programs.ssh.enable = true;
    home = {
      username = settings.username;
      homeDirectory = "/home/${settings.username}";
      stateVersion = settings.homeStateVersion;
      # sessionVariables = {};
      sessionPath = [ "$HOME/.local/bin" ];
    };
    manual = {
      # disable manuals as nmd fails to build often
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };
  };
}
