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
      stateVersion = settings.home.stateVersion;
      sessionPath =
        [ "$HOME/.bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.go/bin" ];

      sessionVariables = {
        PAGER = "less";
        LESS = "-R";
        VIRTUAL_ENV_DISABLE_PROMPT = "1";
        PIPENV_SHELL_FANCY = "1";
        ERL_AFLAGS = "-kernel shell_history enabled";
      };
    };
    manual = {
      # You can Disable manuals as nmd fails to build often
      html.enable = true;
      json.enable = true;
      manpages.enable = true;
    };
  };
}
