{ settings, pkgs, ... }: {
  imports = [ ./security.nix ];

  security = {
    # rtkit is recommended for pipewire
    rtkit.enable = true;

    # Enable polkit. polkit-kde-agent needs to be installed and started at boot seperately (will be done with Hyprland)
    polkit.enable = true;

    # Swaylock needs an entry in PAM to proberly unlock
    pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';

    # Enable basic tpm2 support
    tpm2 = {
      enable = false;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };
}
