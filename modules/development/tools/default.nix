{ settings, config, lib, pkgs, ... }: {
  imports = lib.optionals (settings.modules.development.tools.enable or false)
    [ ./editors ];
}
