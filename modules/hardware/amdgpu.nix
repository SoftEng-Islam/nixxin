{ settings, lib, pkgs, ... }: {
  environment.variables = { };
  environment.systemPackages = with pkgs; [ ];
  home-manager.users."${settings.users.selected.username}" = {

  };
}
