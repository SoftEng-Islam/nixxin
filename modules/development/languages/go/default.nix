{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.go.enable or false) {
    environment.variables = {
      # FIX ME: What is GOPROXY
      GOPROXY = "direct";
    };
    home-manager.users.${settings.user.username} = {
      programs.go = { enable = true; };
    };
    environment.systemPackages = with pkgs; [ go ];
  };
}
