{
  home.file.".config/electron-flags.conf" = {
    text = ''
      --ozone-platform-hint=wayland
      --gtk-version=4
      --ignore-gpu-blocklist
      --enable-features=TouchpadOverscrollHistoryNavigation
      --enable-wayland-ime
      --password-store=gnome-libsecret
    '';
  };
}