{ inputs, settings, pkgs, ... }: {
  # If you have graphical issues like missing transparency or graphical artifact you could launch ashell with WGPU_BACKEND=gl.
  #  This env var forces wgpu to use OpenGL instead of Vulkan
  environment.systemPackages = with pkgs;
    [
      # (import (pkgs.callPackage (pkgs.fetchFromGitHub {
      #   owner = "MalpenZibo";
      #   repo = "ashell";
      #   rev = "refs/heads/main"; # Or specify the branch/tag you need
      #   sha256 = "sha256-PLACEHOLDER"; # Replace with the correct hash
      # }) { }).defaultPackage.x86_64-linux)

      inputs.ashell.packages.${pkgs.system}.default
    ];
}
