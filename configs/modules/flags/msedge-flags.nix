{
  home.file.".config/msedge-flags.conf" = {
    text = ''
      --password-store=gnome-libsecret
      --ozone-platform-hint=wayland
      --gtk-version=4
      --ignore-gpu-blocklist
      --enable-features=TouchpadOverscrollHistoryNavigation
      --enable-wayland-ime
    '';
  };
}