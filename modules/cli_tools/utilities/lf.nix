{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.lf = {
      enable = true;
      commands = {
        dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
        editor-open = "$$EDITOR $f";
        mkdir =
          "	\${{\n		printf \"Directory Name: \"\n		read DIR\n		mkdir $DIR\n	}}\n";
      };
      keybindings = {
        "\\\"" = "";
        o = "";
        c = "mkdir";
        "." = "set hidden!";
        "`" = "mark-load";

      };
      settings = {
        preview = true;
        hihdden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };
    };
  };
  environment.systemPackages = with pkgs;
    [
      lf # Terminal file manager written in Go and heavily inspired by ranger
    ];
}
