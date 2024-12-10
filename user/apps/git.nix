{ pkgs, ... }: {
  home.packages = [ pkgs.git ];
  programs.git.enable = true;
  programs.git.userName = "Islam Ahemd";
  programs.git.userEmail = "softeng.islam@gmail.com";
  programs.git.extraConfig = { core.editor = "nvim"; };
}
