{ config, pkgs, settings, ... }: {
  imports = [
    (./. + "../../../user/wm" + ("/" + builtins.elemAt settings.wm 0) + ".nix")
    (./. + "../../../user/wm" + ("/" + builtins.elemAt settings.wm 1) + ".nix")
    ../../themes/stylix.nix
    ../../user/apps/spotify.nix
    ../../user/apps/kitty.nix
    ../../user/apps/git.nix
    ../../user/apps/superfile.nix
    ../../user/apps/zathura.nix
    ../../user/apps/nemu.nix
    ../../user/apps/cava.nix
    ../../user/apps/khal.nix
    ../../user/apps/vdirsyncer.nix
    ../../user/apps/neofetch
    ../../user/shell/zsh.nix
    ../../user/apps/mangohud.nix
    ../../user/apps/neovim
    ../../user/apps/btop
    ../../user/apps/mpd
  ];

  stylix.targets.hyprland.enable = false;

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
  };

  # Add packages from the pkgs dir
  nixpkgs.overlays = import ../../lib/overlays.nix;
  nixpkgs.config.allowUnfree = true; # Sorry, Stallman(
  home.packages = with pkgs; [
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
    teleport # Certificate authority and access plane for SSH
    openvpn # Robust and highly flexible tunneling application
    sway-contrib.grimshot # Helper for screenshots within sway
    libreoffice-fresh
    obs-studio
    tty-clock
    qbittorrent
    rtorrent
    cpulimit
    swayimg
    vesktop
    revolt-desktop
    telegram-desktop
    wayvnc
    drawio
    gimp
    mpv

    # Overclock
    dmidecode
    sysbench

    # Sometimes needed for work.
    zoom-us
    chromium
    translate-shell
    tlaplus18

    # These packages are compulsury.
    # settings.editorPkg
    settings.browserPkg
    settings.termPkg
  ];

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    templates = null;
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${settings.dotfilesDir}";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };

  home.sessionVariables = {
    EDITOR = settings.editor;
    TERM = settings.term;
    BROWSER = settings.browser;
  };

  # programs.sagemath.enable = true;
  services.kdeconnect.enable = true;
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = settings.icons;
      package = settings.iconsPkg;
    };
  };

  home.stateVersion = "24.11";
}
