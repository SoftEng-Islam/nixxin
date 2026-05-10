{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.ssh = {
      enable = true;
    };

    home.packages = with pkgs; [
      openssh
      gnupg
      pinentry-curses
      sops
      rage
      ssh-to-age
      paperkey
      yubikey-personalization
      age-plugin-yubikey
      libfido2
      pam_u2f
      yubico-piv-tool
    ];
  };
}
