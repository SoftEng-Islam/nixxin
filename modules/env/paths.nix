{
  # enable completions for system packages
  # and other stuff
  environment.pathsToLink = [
    "/share/zsh" # zsh completions
    "/share/bash-completion" # bash completions
    "/share/nix-direnv" # direnv completions
    "/lib/pkgconfig" # library pkg-config definitions
    "/share/pkgconfig" # non-arch pkg-config definitions
  ];
}
