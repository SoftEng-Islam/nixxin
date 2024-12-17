{ config, pkgs, settings, ... }: {
  imports = [

    # (./. + "../../../user/wm" + ("/" + builtins.elemAt settings.wm 0) + ".nix")
    # (./. + "../../../user/wm" + ("/" + builtins.elemAt settings.wm 1) + ".nix")

    (./. + "../../../user/wm" + ("/" + builtins.elemAt settings.wm 0))
    (./. + "../../../user/wm" + ("/" + builtins.elemAt settings.wm 1))

    ../../themes/stylix.nix
    ../../user/media
    ../../user/cava.nix
    ../../user/curl.nix
    ../../user/git.nix
    ../../user/ssh.nix
    ../../user/superfile.nix
  ];

  stylix.targets.hyprland.enable = false;

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #  /etc/profiles/per-user/softeng/etc/profile.d/hm-session-vars.sh
    sessionVariables = {
      EDITOR = settings.editor;
      TERM = settings.term;
      BROWSER = settings.browser;
    };
    # The home.packages option allows you to install Nix packages into your environment.
    packages = with pkgs; [
      qt5.qtgraphicaleffects
      qt5.qtquickcontrols2
      # yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
      # teleport # Certificate authority and access plane for SSH
      # openvpn # Robust and highly flexible tunneling application
      # sway-contrib.grimshot # Helper for screenshots within sway
      # libreoffice-fresh
      # obs-studio
      # tty-clock
      # qbittorrent
      # rtorrent
      # cpulimit
      # swayimg
      # vesktop
      # revolt-desktop
      # telegram-desktop

      # drawio
      # gimp
      # mpv

      # Overclock
      # dmidecode
      # sysbench

      # Sometimes needed for work.
      # zoom-us
      # chromium
      # translate-shell
      # tlaplus18

      # These packages are compulsury.
      # settings.editorPkg
      settings.browserPkg
      settings.termPkg
    ];
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.
  };

  # Add packages from the pkgs dir
  nixpkgs.config.allowUnfree = true;

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

  # programs.sagemath.enable = true;
  services.kdeconnect.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = settings.icons;
      package = settings.iconsPkg;
    };
  };

}
