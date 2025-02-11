{ pkgs, ... }: {
  security = {
    sudo.enable = true;

    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;

    # show Password as stars in Terminals.
    sudo.extraConfig = "Defaults        env_reset,pwfeedback";

    allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading

    polkit.enable = true;
    isolate.enable = false;

    sudo.configFile = ''
      root   ALL=(ALL:ALL) SETENV: ALL
      %wheel ALL=(ALL:ALL) SETENV: ALL
      celes  ALL=(ALL:ALL) SETENV: ALL
    '';
  };
  environment.systemPackages = with pkgs; [
    openvpn # Robust and highly flexible tunneling application
    protonvpn-cli # Linux command-line client for ProtonVPN
  ];
}
