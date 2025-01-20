{ settings, pkgs, ... }:
let
  plugins = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-volman # auto mont devices
  ];
  finalThunar = pkgs.xfce.thunar.override { thunarPlugins = plugins; };
in {

  programs.thunar = {
    enable = true;
    inherit plugins;
  };
  environment = {
    systemPackages = with pkgs; [

      # required by tumbler service
      # TODO: add https://gitlab.com/hxss-linux/folderpreview
      ffmpegthumbnailer # videos
      freetype # fonts
      gdk-pixbuf # images
      libgepub # .epub
      libgsf # .odf
      poppler # .pdf .ps
      webp-pixbuf-loader # .webp
    ];
  };
  home-manager.users.${settings.username} = {
    # xdg.configFile."Thunar/uca.xml".source = ./dotfiles/Thunar/uca.xml;
    xdg.desktopEntries.thunar = {
      name = "Thunar File Manager";
      exec = "Thunar %U";
    };
    xdg.mimeApps = {
      defaultApplications = { "inode/directory" = [ "thunar.desktop" ]; };
      associations.added = { "inode/directory" = [ "thunar.desktop" ]; };
    };

    systemd.user.services.thunar = {
      Unit = {
        Description = "Thunar file manager";
        Documentation = "man:Thunar(1)";
      };
      Service = {
        Type = "dbus";
        ExecStart = "${finalThunar}/bin/Thunar --daemon";
        BusName = "org.xfce.FileManager";
        KillMode = "process";
        # NOTE: PATH is necessary for when thunar is launched by browsers
        PassEnvironment = [ "PATH" ];
      };
    };
  };
}
