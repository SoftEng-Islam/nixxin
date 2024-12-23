 home-manager = {
    # users = { mySettings.username = import ./home.nix; };
    users.${mySettings.username} = {
      isNormalUser = true;
      programs.bash.enable = true;
      stylix.targets.hyprland.enable = false;
      useGlobalPkgs = true;
      useUserPackages = false;
      home = {
        stateVersion = mySettings.homeStateVersion;
        username = mySettings.username;
        homeDirectory = "/home/${mySettings.username}";
        # Home Manager can also manage your environment variables through
        # 'home.sessionVariables'. These will be explicitly sourced when using a
        # shell provided by Home Manager. If you don't want to manage your shell
        # through Home Manager then you have to manually source 'hm-session-vars.sh'
        # located at either
        #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
        #  /etc/profiles/per-user/softeng/etc/profile.d/hm-session-vars.sh
        sessionVariables = {
          EDITOR = mySettings.editor;
          TERM = mySettings.term;
          BROWSER = mySettings.browser;
        };
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
      };
      programs = {
        # sagemath.enable = true;
        # Let Home Manager install and manage itself.
        home-manager.enable = true;
      };
      gtk = {
        enable = true;
        cursorTheme = {
          name = mySettings.cursorTheme;
          size = mySettings.cursorSize;
          package = mySettings.cursorPackage;
        };
        font = {
          name = mySettings.fontName;
          package = mySettings.fontPackage;
          size = mySettings.fontSize;
        };
        iconTheme = {
          name = mySettings.iconName;
          package = mySettings.iconPackage;
        };
        theme = {
          name = lib.mkForce mySettings.gtkTheme;
          package = lib.mkForce mySettings.gtkPackage;
        };
        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };
      xdg = {
        enable = true;
        configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
        userDirs = {
          enable = true;
          createDirectories = true;
          music = "${config.home.homeDirectory}/Music";
          videos = "${config.home.homeDirectory}/Videos";
          pictures = "${config.home.homeDirectory}/Pictures";
          download = "${config.home.homeDirectory}/Downloads";
          documents = "${config.home.homeDirectory}/Documents";
          templates = null;
          desktop = null;
          publicShare = null;
          extraConfig = {
            XDG_DOTFILES_DIR = "${mySettings.dotfilesDir}";
            XDG_BOOK_DIR = "${config.home.homeDirectory}/Books";
          };
        };
      };

      # disable manuals as nmd fails to build often
      manual = {
        html.enable = false;
        json.enable = false;
        manpages.enable = false;
      };

      # QT Settings
      qt = {
        enable = true;
        platformTheme.name = mySettings.qtPlatformTheme;
        style.name = mySettings.qtStyle;
      };
    };
  };