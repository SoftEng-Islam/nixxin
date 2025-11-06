{
  description = "Nix flake for clvk - OpenCL on Vulkan";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    clvk-src = {
      url = "github:KhronosGroup/clvk";
      flake = false;
    };

}

"kpet/clvk-git"
