{
  pkgs,
  ...
}:
{
  # -----------------------------------
  # hyprpolkitagent
  # -----------------------------------
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    polkit # Toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  ];

}
