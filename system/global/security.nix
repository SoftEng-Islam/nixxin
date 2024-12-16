{
  # Security
  security = {
    allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
    sudo.extraConfig =
      "Defaults        env_reset,pwfeedback"; # show Password as stars in Terminals.
    #selinux = null;
    polkit.enable = true;
    #polkit.debug = true;
  };
}
