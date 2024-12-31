{ pkgs, ... }: {
  home.packages = with pkgs;
    [

    ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
