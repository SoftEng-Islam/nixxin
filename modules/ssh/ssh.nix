{ settings, lib, pkgs, ... }: {
  services.openssh.enable = true; # Enable the OpenSSH daemon.
  environment.systemPackages = with pkgs;
    [

    ];
  home-manager.users.${settings.user.username} = {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    services.ssh-agent = {
      enable = lib.modules.mkIf pkgs.stdenv.isLinux true;
    };
  };
}
