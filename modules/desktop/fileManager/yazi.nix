{
  pkgs,
  ...
}:
{
  programs.yazi.enable = true;
  # programs.yazi.flavors = {
  #   foo = ./foo;
  #   inherit (pkgs.yaziPlugins) bar;
  # };
  environment.systemPackages = with pkgs; [
    yazi
  ];
}
