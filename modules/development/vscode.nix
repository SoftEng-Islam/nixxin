{
  settings,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.vscode = {
      enable = true;
      userSettings = {
        # Prevent VSCode from scanning Nix build outputs (e.g. `result` -> /nix/store),
        # which can make the UI/search/indexing painfully slow.
        "search.followSymlinks" = false;
        "files.watcherExclude" = {
          "**/.git/objects/**" = true;
          "**/.git/subtree-cache/**" = true;
          "**/.direnv/**" = true;
          "**/.devenv/**" = true;
          "**/node_modules/**" = true;
          "**/result/**" = true;
          "**/result-*/**" = true;
        };
        "search.exclude" = {
          "**/.direnv/**" = true;
          "**/.devenv/**" = true;
          "**/node_modules/**" = true;
          "**/result/**" = true;
          "**/result-*/**" = true;
        };
        "files.exclude" = {
          "**/.direnv" = true;
          "**/.devenv" = true;
          "**/result" = true;
          "**/result-*" = true;
        };
      };
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
    xdg.mimeApps.associations.removed = {
      "inode/directory" = "code.desktop";
    };
  };
}
