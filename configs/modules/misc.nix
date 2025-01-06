{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

  ];
}
