{ pkgs, ... }: {
  imports = [
    # /android
    ./android/pkgs.nix

    # /apps
    ./apps/browsers.nix
    ./apps/community-apps.nix
    ./apps/desktop-apps.nix
    ./apps/download-manager.nix
    ./apps/graphic-apps.nix
    ./apps/media-player.nix
    ./apps/nautilus.nix
    ./apps/office.nix

    # /development
    ./development/cli-tools.nix
    ./development/dev-apps.nix
    ./development/dev-pkgs.nix
    ./development/editors.nix
    ./development/git.nix
    ./development/hacking.nix
    ./development/javascript.nix
    ./development/python.nix
    ./development/rust.nix
    ./development/spell-checker.nix
    ./development/terminals.nix

    # /drivers
    ./drivers/drivers.nix
    ./drivers/media.nix

    # /gaming
    ./gaming/gameing.nix
    # ./gaming/lutris.nix
    ./gaming/steam.nix

    # /hardware
    ./hardware/desktop/audio.nix
    ./hardware/desktop/boot.nix
    ./hardware/desktop/graphic.nix
    # ./hardware/desktop/mouse.nix
    # ./hardware/desktop/printing.nix

    # /os
    ./os/appearance.nix
    ./os/clipboard.nix
    ./os/environment.nix
    ./os/locale.nix
    ./os/networking.nix
    ./os/nixos.nix
    ./os/notifications.nix
    ./os/power-management.nix
    ./os/programs.nix
    ./os/screenshots.nix
    ./os/services.nix
    ./os/users.nix
    ./os/zram.nix

    # /security
    # ./security/vpn.nix

    # /virtualization
    # ./virtualization/general.nix
    # ./virtualization/nemu/default.nix

    # /windows
    ./windows/wine.nix

    # /window-manager
    ./wm/gnome.nix
    ./wm/hyprland.nix

  ];
}
