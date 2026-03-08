{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      appLauncher = {
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        enableClipPreview = true;
        enableClipboardHistory = true;
        position = "center";
        backgroundOpacity = 1.0;
        pinnedExecs = [ ];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "xterm -e";
        viewMode = "list";
        autoPasteClipboard = false;
        clipboardWrapText = true;
        iconMode = "tabler";
        ignoreMouseInput = false;
        pinnedApps = [ ];
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
      };
    };
  };
}
