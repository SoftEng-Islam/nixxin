{
  # Security
    # show Password as stars in Terminals.
    security.sudo.extraConfig = "Defaults        env_reset,pwfeedback";

    security.allowSimultaneousMultithreading = true; # to allow SMT/hyperthreading
    security.polkit.enable = true;
    security.pam.services.astal-auth = { };
    #security.selinux = null;
}
