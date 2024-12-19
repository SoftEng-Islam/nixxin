{ settings, pkgs, lib, config, ... }: {
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
    # ../../user/superfile.nix
  ];

  stylix.targets.hyprland.enable = false;
  # programs.sagemath.enable = true;
  services.kdeconnect.enable = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.ssh-agent.enable = true;

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
    pointerCursor = {
      package = settings.cursorPackage;
      name = settings.cursorTheme;
      size = settings.cursorSize;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
      hyprcursor.size = settings.cursorSize;
    };
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

  xdg = {
    enable = true;
    configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
    userDirs = {
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
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # GTK Settings
  gtk = {
    enable = true;

    cursorTheme = {
      name = settings.cursorTheme;
      size = settings.cursorSize;
      package = settings.cursorPackage;
    };

    font = {
      name = settings.fontName;
      package = settings.fontPackage;
      size = settings.fontSize;
    };

    iconTheme = {
      name = settings.iconName;
      package = settings.iconPackage;
    };

    theme = {
      name = settings.gtkTheme;
      package = settings.gtkPackage;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  # QT Settings
  qt = {
    enable = true;
    platformTheme = settings.qtPlatformTheme;
    style.name = settings.qtStyle;
  };

  environment.systemPackages = with pkgs; [
    # Themes & Graphical Interfaces
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk_engines # Theme engines for GTK 2
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME

    adw-gtk3 # Theme from libadwaita ported to GTK-3
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette
    colloid-gtk-theme # Modern and clean Gtk theme

    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # Icons
    gruvbox-dark-icons-gtk
    gruvbox-plus-icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # QT Themes
    adwaita-qt
    adwaita-qt6
  ];
}
