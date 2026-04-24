{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      templates = {
        gtk = false;
        qt = false;
        kcolorscheme = false;
        kitty = false;
        ghostty = false;
        foot = false;
        fuzzel = false;
        discord = false;
        discord_vesktop = false;
        discord_webcord = false;
        discord_armcord = false;
        discord_equibop = false;
        discord_lightcord = false;
        discord_dorion = false;
        pywalfox = false;
        enableUserTemplates = false;
        activeTemplates = [ ];
        enableUserTheming = false;
      };
    };
  };
}
