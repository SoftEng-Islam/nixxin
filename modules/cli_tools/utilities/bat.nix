{ settings, lib, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
      config = {
        map-syntax = [ "*.jenkinsfile:Groovy" "*.props:Java Properties" ];
        pager = "less -FR";
        theme = "TwoDark";
      };
      # syntaxes = { };
      # themes = { };
    };
  };
}
