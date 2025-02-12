{ settings, pkgs, ... }: {
  environment.variables = {
    # FIX ME: what is GOPROXY
    GOPROXY = "direct";
  };
  home-manager.users.${settings.user.username} = {
    programs.go = { enable = true; };
  };
  environment.systemPackages = with pkgs; [ go ];
}
