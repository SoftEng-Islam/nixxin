# let
#   defaultFont =
#     "${config.gtk.font.name},${builtins.toString config.gtk.font.size}";
# in
{
  xdg.configFile = {
    # qtct config
    "qt5ct/qt5ct.conf".text = "";
    "qt6ct/qt6ct.conf".text = "";
  };
}
