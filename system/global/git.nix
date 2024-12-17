{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    delta
    git # Distributed version control system
    git-absorb
    git-lfs
    lazygit # Simple terminal UI for git commands
    mergiraf
    tig # Text-mode interface for git
  ];
}
