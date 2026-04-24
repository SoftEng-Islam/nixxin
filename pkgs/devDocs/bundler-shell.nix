# ./bundler-shell.nix
with (import <nixpkgs> { });
let myBundler = bundler.override { ruby = ruby_3_4; };
in mkShell {
  name = "bundler-shell";
  buildInputs = [ myBundler ];
}
