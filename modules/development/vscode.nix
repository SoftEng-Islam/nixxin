{
  settings,
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package =
      (pkgs.vscode.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          # wrapProgram $out/bin/code \
          #  --run "exec 2>/dev/null"
        '';
      })).override
        {
          isInsiders = false;
          # Configure VSCode to run without requiring --no-sandbox
          useVSCodeRipgrep = true;
          commandLineArgs = builtins.concatStringsSep " " [
            "--ozone-platform=wayland"
            "--enable-wayland-ime"
            # Keep rendering at 1:1 to avoid fractional scaling performance issues.
            "--force-device-scale-factor=1"
            "--password-store=gnome" # use gnome-keyring as password store
          ];
        };
  };
  home-manager.users.${settings.user.username} = {
    xdg.mimeApps.associations.removed = {
      "inode/directory" = "code.desktop";
    };
  };
}
