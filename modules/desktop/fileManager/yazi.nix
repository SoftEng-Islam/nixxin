{
  pkgs,
  ...
}:
{

  programs.yazi = {
    enable = true;
    flavors = {
      inherit (pkgs.yaziFlavors)
        vscode-dark-modern
        vscode-light-modern
        ;
    };
    theme.flavor = {
      dark = "vscode-dark-modern";
      light = "vscode-light-modern";
    };
    settings = {
      mgr = {
        ratio = [
          1
          3
          4
        ];
        show_hidden = true;
        show_symlink = true;
        linemode = "size";
      };
      preview.wrap = "yes";
    };
  };

  environment.systemPackages = with pkgs; [
    yazi
  ];
}
