{
  pkgs,
  ...
}:
{
  programs.yazi.enable = true;

  environment.systemPackages = with pkgs; [
    yazi
  ];
}
