{ pkgs, ... }: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    sshfs

    # utils
    du-dust
    duf
    fd
    file
    jaq
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
