{ inputs, settings, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.desktop.enable or false) [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./dconf.nix
    ./keyring.nix
    ./polkit.nix
    ./ashell
    ./hyprland
    ./file_manager.nix
    ./image_viewer.nix
    ./qt_gtk.nix
    ./screenshot.nix
    ./tools.nix
    ./quickShell
    ./rofi.nix
    ./noctalia.nix
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      # Extra libraries and packages for Appimage run
      extraPkgs = pkgs: with pkgs; [ ffmpeg imagemagick ];
    };
  };

  services.flatpak.enable = true;

  home-manager.users.${settings.user.username} = {
    xdg.configFile = {
      # "hypr/hyprshade.toml".text = ''
      #   [[shades]]
      #   name = "blue-light-filter"
      #   start_time = 19:00:00
      #   end_time = 06:00:00
      # '';

      # Copied from: https://github.com/TheRiceCold/dots/blob/d25001db1529195174b214fe61e507522ea2195d/home/wolly/kaizen/desktop/wayland/hyprland/ecosystem/hyprshade.nix#L35C4-L50C8
      # "hypr/shaders/grayscale.glsl".text = '''';

      # Edited from: https://github.com/loqusion/hyprshade/blob/main/shaders/blue-light-filter.glsl.mustache
      # "hypr/shaders/blue-light-filter.glsl.mustache".text = '''';
    };
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.startsWith("org.freedesktop.Flatpak.")) return polkit.Result.YES;
    });
  '';

  systemd.services.flathub-repo.wants = [ "network-online.target" ];
  systemd.services.flathub-repo.after = [ "network-online.target" ];
  systemd.services.flathub-repo.wantedBy = [ "network-online.target" ];
  systemd.services.flathub-repo.enable = true;

  systemd.services.flathub-repo.script = ''
    doneFile=/var/lib/flatpak/INITIALIZED
    [ -e $doneFile ] && exit
    flatpak=${pkgs.flatpak}/bin/flatpak
    notifysend=${pkgs.libnotify}/bin/notify-send
    runuser=/run/current-system/sw/bin/runuser
    sleep 30 &&
    active_session=$(loginctl show-seat seat0 | grep "^ActiveSession=" | sed 's|ActiveSession=||')
    show_session_x=$(loginctl show-session "$active_session")
    desktop_user_id=$(printf "$show_session_x" | grep "^User" | sed 's|User=||')
    desktop_user_name=$(printf "$show_session_x" | grep "^Name" | sed 's|Name=||')
    export DISPLAY=:0
    export XDG_RUNTIME_DIR=/run/user/"$desktop_user_id"
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$desktop_user_id/bus
    toast="$runuser -u $desktop_user_name -- $notifysend"
    notification_id=$($toast -p "Installing Flathub..." "Adding Remote");
    $flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo;
    $toast -r $notification_id -e "Installing Flathub..." "Giving Steam flatpak permissions to use /steamapps";
    $flatpak override com.valvesoftware.Steam --filesystem=/steamapps;
    # $toast -r $notification_id "Installing Flathub..." "Downloading Apps";
    # $flatpak install -y com.brave.Browser org.kde.dolphin com.mattjakeman.ExtensionManager net.mullvad.MullvadBrowser org.mozilla.Thunderbird org.pulseaudio.pavucontrol &&
    touch $doneFile;
    $toast -r $notification_id -e "...Flathub installed" "...done"
  '';

  environment.systemPackages = with pkgs; [
    # Run this to add the flathub repo
    # sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    bazaar
    flatpak
    gnome-software
    hyprshade
  ];
}
