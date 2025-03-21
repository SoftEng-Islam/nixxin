{ pkgs, ... }: {
  services = {
    greetd.enable = true;
    greetd.settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
      user = "greeter";
    };
  };
  environment.systemPackages = with pkgs;
    [
      greetd
      # greetd-mini-wl-greeter
    ];
}
