{ settings, lib, ... }:
let
  gtk-theme = settings.gtkTheme;
  cursor-theme = settings.cursorTheme;
  cursor-package = settings.cursorPackage;
in {
  home = {
    sessionVariables = {
      XCURSOR_THEME = cursor-theme;
      XCURSOR_SIZE = toString.settings.cursorSize;
    };
    # pointerCursor = {
    #   package = cursor-package;
    #   name = cursor-theme;
    #   size = 24;
    #   gtk.enable = true;
    # };
  };

  gtk = {
    enable = true;
    font.name = settings.sansSerifFont;
    theme.name = lib.mkForce gtk-theme;
    cursorTheme = {
      name = cursor-theme;
      package = cursor-package;
    };
    gtk3.extraCss = ''
      headerbar, .titlebar,
      .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
        border-radius: 0;
      }
    '';
  };
}
