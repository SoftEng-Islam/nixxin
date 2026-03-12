{
  settings,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.yazi = {
      enable = true;
      plugins = with pkgs.yaziPlugins; {
        inherit nord yatline;
      };

      flavors = { inherit (pkgs.yaziPlugins) nord; };

      theme.flavor = {
        light = "nord";
        dark = "nord";
      };

      initLua = /* lua */ ''
        require("yatline"):setup({
          theme = require("nord"):setup(),
        })
      '';
      settings = {
        manager = {
          show_hidden = false;
          sort_by = "mtime";
          sort_dir_first = true;
          sort_reverse = true;
        };
        preview.wrap = "yes";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    yazi
  ];
}
