{ settings, ... }:
{
  home-manager.users.${settings.user.username}.programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = settings.user.name;
        email = settings.user.email;
      };
      ui = {
        pager = "less -FRX";
        show-cryptographic-signatures = true;
      };
      signing = {
        backend = "gpg";
        behaviour = "own"; # Default to own since user has GPG enabled
      };
      # Template aliases and templates preserved from original
      template-aliases = {
        "gerrit_change_id(change_id)" = ''
          "Id0000000" ++ change_id.normal_hex()
        '';
      };
      templates = {
        draft_commit_description = ''
          concat(
            description,
            indent("JJ: ", concat(
              if(
                !description.contains("Change-Id: "),
                "Change-Id: " ++ gerrit_change_id(change_id) ++ "\n",
                "",
              ),
              "Change summary:\n",
              indent("     ", diff.summary()),
              "Full change:\n",
              "ignore-rest\n",
            )),
            diff.git(),
          )
        '';
      };
    };
  };
}
