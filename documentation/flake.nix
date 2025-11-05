{
  description = "MkDocs environment for NixOS dotfiles";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs =
        nixpkgs.legacyPackages.x86_64-linux; # Define `pkgs` for convenience
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python3
          pkgs.python3Packages.pip
          pkgs.python3Packages.mkdocs
          pkgs.python3Packages.mkdocs-material
        ];
      };
    };
}
