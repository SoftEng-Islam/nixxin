{ settings, lib, pkgs, ... }: {
  imports = [ ./applications ./display ./services ./theming ./theming ./wm ];
}
