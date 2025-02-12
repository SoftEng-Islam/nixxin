{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  services = {
    greetd.enable = false;
    greetd.settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
      user = "greeter";
    };
  };
}
