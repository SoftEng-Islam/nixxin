{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git-lfs
    mergiraf
    tig
    lazygit
    git-absorb
    delta
    bat
  ];
}
