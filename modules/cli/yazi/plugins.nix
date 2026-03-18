{ inputs, pkgs, ... }:
{
  augment-command = "${inputs.yazi-augment-command}";
  chmod = "${inputs.yazi-plugins}/chmod.yazi";
  compress = "${inputs.yazi-compress}";
  full-border = "${inputs.yazi-plugins}/full-border.yazi";
  git = "${inputs.yazi-plugins}/git.yazi";
  hexyl = "${inputs.yazi-hexyl}";
  mount = "${inputs.yazi-plugins}/mount.yazi";
  toggle-pane = "${inputs.yazi-plugins}/toggle-pane.yazi";
  what-size = "${inputs.yazi-what-size}";
}
