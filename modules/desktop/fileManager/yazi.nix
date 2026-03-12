{
  settings,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.yazi = {
      enable = true;
      initLua = ''
        require("full-border"):setup()
        require("git"):setup()
        require("yatline"):setup({
            theme = require("yatline-catppuccin"):setup("mocha"),
        })
      '';

      plugins = with pkgs.yaziPlugins; {
        inherit
          full-border
          git
          glow
          nord
          smart-paste
          vcs-files
          wl-clipboard
          yatline
          yatline-catppuccin
          ;
      };
      settings = {
        mgr = {
          show_hidden = true;
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
