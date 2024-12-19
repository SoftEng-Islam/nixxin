{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    delta # Syntax-highlighting pager for git
    git # Distributed version control system
    git-absorb
    git-lfs # Git extension for versioning large files
    lazygit # Simple terminal UI for git commands
    mergiraf # Syntax-aware git merge driver for a growing collection of programming languages and file formats
    tig # Text-mode interface for git
    gh # GitHub CLI tool
  ];
}
