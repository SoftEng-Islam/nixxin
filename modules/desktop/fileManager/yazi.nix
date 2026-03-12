{
  settings,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.yazi = {
      enable = true;
      flavors = {
        inherit (pkgs.yaziFlavors)
          vscode-dark-plus
          vscode-light-plus
          ;
      };
      theme.flavor = {
        dark = "vscode-dark-plus";
        light = "vscode-light-plus";
      };
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
