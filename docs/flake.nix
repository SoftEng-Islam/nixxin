{
  description = "MkDocs environment for NixOS dotfiles";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    devShells.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = [
        nixpkgs.python3
        nixpkgs.python3Packages.pip
        nixpkgs.python3Packages.mkdocs
        nixpkgs.python3Packages.mkdocs-material
      ];
    };
  };
}
