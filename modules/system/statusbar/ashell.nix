{ inputs, settings, pkgs, ... }: {
  # If you have graphical issues like missing transparency or graphical artifact you could launch ashell with WGPU_BACKEND=gl.
  #  This env var forces wgpu to use OpenGL instead of Vulkan
  environment.systemPackages = with pkgs;
    [
      (import (pkgs.callPackage (pkgs.fetchFromGitHub {
        owner = "MalpenZibo";
        repo = "ashell";
        # "rev": "018f6a26e242d8438921ecb1c65ddef4a07fe070",
        rev = "refs/heads/main"; # Or specify the branch/tag you need
        # $ nix-prefetch-git https://github.com/MalpenZibo/ashell
        sha256 =
          "0f44vzf28nx2fj13bnlrk1j5ad6gmr74np4pk5ysyx0k17xjgvzl"; # Replace with the correct hash
      }) { }).defaultPackage.x86_64-linux)

      # inputs.ashell.packages.${pkgs.system}.default
    ];
}
