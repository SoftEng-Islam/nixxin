{
  description = "MkDocs environment for NixOS dotfiles";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      pkgs =
        nixpkgs.legacyPackages.x86_64-linux; # Define `pkgs` for convenience
      # Bundle MkDocs with its theme/plugins in one Python closure so plugin discovery works.
      mkdocsEnv = pkgs.python3.withPackages (
        ps: with ps; [
          mkdocs
          mkdocs-material
          mkdocs-minify-plugin
          pymdown-extensions
        ]
      );
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          mkdocsEnv
        ];
      };
    };
}
