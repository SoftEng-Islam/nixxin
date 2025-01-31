{ lib, settings, pkgs, ... }: {
  imports = (lib.optional settings.gnome.enable [ ./gnome ])
    ++ (lib.optional settings.COSMIC.enable [ ./COSMIC ])
    ++ (lib.optional settings.plasma.enable [ ./plasma ]);
}
