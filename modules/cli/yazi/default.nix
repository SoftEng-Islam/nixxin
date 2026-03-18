{
  settings,
  pkgs,
  config,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      package = pkgs.update.yazi;
      settings = import ./yazi_settings.nix;
      keymap = import ./keymap.nix;
      theme = import ./theme.nix;
      flavors = import ./flavors.nix { inherit pkgs; };
      plugins = import ./plugins.nix { inherit pkgs; };
      shellWrapperName = "y";
      initLua = ''
        -- require("full-border"):setup()
        -- require("git"):setup()

        -- Custom configuration for augment-command
        require("augment-command"):setup({
          smart_paste = true,
          smart_tab_create = true,
        })

        -- Makes yazi update the zoxide database on navigation
        require("zoxide"):setup
        {
          update_db = true,
        }
      '';
    };
  };
}
