{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tig # Text-mode interface for git

    git # Distributed version control system
    lazygit # Simple terminal UI for git commands
    git-lfs
    mergiraf
    tig
    lazygit
    git-absorb
    delta
    bat
  ];
}
