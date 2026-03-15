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
              "--disable-font-subpixel-positioning=true"
              "--ozone-platform-hint="
              "--ozone-platform=wayland"
              "--enable-features=WaylandWindowDecorations"
              # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
              # (only supported by chromium/chrome at this time, not electron)
              "--gtk-version=4"
              # make it use text-input-v1, which works for kwin 5.27 and weston
              "--enable-wayland-ime"

              "--in-process-gpu" # Force GPU acceleration to be in-process, which is more compatible with Wayland and can improve performance and stability.

              # 2. THE FIX: Force it to ignore System 1.25x and render at 1:1
              "--force-device-scale-factor=1"

              # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
              # (only supported by chromium/chrome at this time, not electron)
              "--gtk-version=4"
              # make it use text-input-v1, which works for kwin 5.27 and weston
              "--enable-wayland-ime"

              # TODO: fix https://github.com/microsoft/vscode/issues/187436
              # still not works...
              "--password-store=gnome" # use gnome-keyring as password store

              # enable hardware acceleration - vulkan api
              "--enable-features=${
                lib.concatStringsSep "," [
                  "enable-wayland-ime"
                  "AcceleratedVideoDecodeLinuxGL"
                  "VaapiVideoDecoder"
                  "VaapiIgnoreDriverChecks"
                  "Vulkan"
                  "DefaultANGLEVulkan"
                  "VulkanFromANGLE"
                ]
              }"

              "--disable-features=${
                lib.concatStringsSep "," [
                  "WaylandFractionalScaleV1"
                  "UseOzonePlatform"
                  "WaylandWindowDecorations"
                ]
              }"
            ];
          };
    };
    xdg.mimeApps.associations.removed = {
      "inode/directory" = "code.desktop";
    };
  };
}
