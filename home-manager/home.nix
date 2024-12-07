{ config, pkgs, ... }:
let
  UserName = "softeng";
  gruvboxPlus = import ./gruvbox-plus.nix { inherit pkgs; };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = UserName;
  home.homeDirectory = "/home/${UserName}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the parentheses.
    # # Maybe you want to install Nerd Fonts with a limited number of fonts?
    # (pkgs.nerdfonts.override { fonts = [ "hack" "fira-code" "jetbrains-mono" ]; })

    # # You can also create simple shell scripts directly inside your configuration.
    # For example, this adds a command 'my-hello' to your environment:
    # (pkgs.writeShellScriptBin "my-hello" '' echo "Hello, ${config.home.username}!" '')
    pkgs.qt5.qtgraphicaleffects
    pkgs.qt5.qtquickcontrols2
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/softeng/etc/profile.d/hm-session-vars.sh

  home.sessionVariables = {
    # EDITOR = "emacs";
    # GTK_IM_MODULE = "ibus";
    # QT_IM_MODULE = "ibus";
    # XMODIFIERS = "@im=ibus";
  };
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
        cache-default = 4000000;
        sub-auto = "fuzzy"; # Automatically load subtitles with a similar name
        # sub-file-paths = "~/subtitles";  # Add a custom directory for subtitles
        sub-font-size = "36"; # Set font size for subtitles
        sub-border-size = "3"; # Set border size for readability
      };
    };
  };

  # ------------------------
  # --- Appearance Section:
  # ------------------------
  qt.enable = true;
  qt.platformTheme = "gtk"; # platform theme "gtk" or "gnome"
  qt.style.name = "adwaita-dark"; # name of the qt theme
  # detected automatically:
  # adwaita, adwaita-dark, adwaita-highcontrast, adwaita-highcontrastinverse,
  # breeze, bb10bright, bb10dark, cde, cleanlooks, gtk2, motif, plastique
  # package to use
  qt.style.package = pkgs.adwaita-qt;

  # GTK
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3";
  gtk.iconTheme.package = gruvboxPlus;
  gtk.iconTheme.name = "GruvboxPlus";

  # better eval time
  manual.html.enable = false;
  manual.manpages.enable = false;
  manual.json.enable = false;
}
