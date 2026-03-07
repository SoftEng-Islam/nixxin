{ settings, lib, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./home.nix

    ../../../../scripts

    # ---- Modules ---- #
    ../../../../modules/ai
    ../../../../modules/android
    ../../../../modules/audio
    ../../../../modules/bluetooth
    ../../../../modules/browsers
    ../../../../modules/camera
    ../../../../modules/cli_tools
    ../../../../modules/community
    ../../../../modules/data_transferring
    ../../../../modules/desktop
    ../../../../modules/development
    ../../../../modules/emails
    ../../../../modules/env
    ../../../../modules/fonts
    ../../../../modules/gaming
    ../../../../modules/git
    ../../../../modules/graphics
    ../../../../modules/hacking
    ../../../../modules/i18n
    ../../../../modules/icons
    ../../../../modules/media
    ../../../../modules/networking
    ../../../../modules/notifications
    ../../../../modules/office
    ../../../../modules/overclock
    ../../../../modules/pkgs
    ../../../../modules/power
    ../../../../modules/printing
    ../../../../modules/recording
    ../../../../modules/remote_desktop
    ../../../../modules/security
    ../../../../modules/sound_editor
    ../../../../modules/ssh
    ../../../../modules/storage
    ../../../../modules/system
    ../../../../modules/users
    ../../../../modules/virtualization
    ../../../../modules/windows
    ../../../../modules/zram
  ];
}
