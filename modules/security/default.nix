{ settings, lib, pkgs, ... }:

let inherit (lib) mkIf;
in mkIf (settings.modules.security.enable) {
  security = {
    sudo.enable = true;
    acme.acceptTerms = true;
    # during testing only 550K-650K of the tmpfs where used
    # wrapperDirSize = "10M";

    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = true;

    # show Password as stars in Terminals.
    sudo.extraConfig = ''
      Defaults        env_reset,pwfeedback
    '';

    allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading

    # Enable polkit. polkit-kde-agent needs to be installed and started at boot seperately (will be done with Hyprland)
    polkit.enable = true;

    # rtkit is recommended for pipewire
    rtkit.enable = true;

    isolate.enable = false;

    sudo.configFile = ''
      root   ALL=(ALL:ALL) SETENV: ALL
      %wheel ALL=(ALL:ALL) SETENV: ALL
      softeng ALL=(ALL:ALL) SETENV: ALL
    '';

    # Swaylock needs an entry in PAM to proberly unlock
    pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';

    # Remove certain resource limits for programs that needs them gone, mostly for heavier emulators.
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "*";
        type = "soft";
        item = "memlock";
        value = "unlimited";
      }
    ];

    # Enable basic tpm2 support
    tpm2 = {
      enable = settings.modules.security.tpm2;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };

    # to create new namespaces.
    unprivilegedUsernsClone = true;
  };
  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    protonvpn-cli # Linux command-line client for ProtonVPN
  ];
}
