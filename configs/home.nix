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
      sessionVariables = {
        EDITOR = settings.editor;
        TERM = settings.term;
        BROWSER = settings.browser;
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";

        PATH = "$HOME/.npm-packages/bin:$HOME/.bun/bin:$PATH";
        NODE_PATH = "$HOME/.npm-packages/lib/node_modules:$NODE_PATH";

        # Fixes `bad interpreter: Text file busy`
        # https://github.com/NixOS/nixpkgs/issues/314713
        UV_USE_IO_URING = "0";

        DIRENV_LOG_FORMAT = "";

        # auto-run programs using nix-index-database
        NIX_AUTO_RUN = "1";
      };
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
