{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "~/Pictures/wallpapers/";
        monitorDirectories = [ ];
        enableMultiMonitorDirectories = false;
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        randomEnabled = true;
        randomIntervalSec = 10000;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 5.0e-2;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "111";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenApiKey = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
        showHiddenFiles = false;
        viewMode = "single";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        automationEnabled = true;
        wallpaperChangeMode = "random";
        sortOrder = "name";
      };
    };
  };
}
