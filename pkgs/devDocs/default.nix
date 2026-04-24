{ pkgs }:

let
  ruby = pkgs.ruby_3_4;
  targetRuby = pkgs.ruby_3_4;
  # myBundler = pkgs.bundler.override { ruby = targetRuby; };
  gems = pkgs.bundlerEnv {
    name = "devdocs-gems";
    # inherit ruby;
    ruby = targetRuby;
    # bundler = myBundler;
    gemdir = ./.;
    extraConfigPaths = [ "${./.}/.ruby-version" ];
  };
in pkgs.stdenv.mkDerivation {
  pname = "devdocs";
  version = "unstable";

  src = ./.;

  nativeBuildInputs = [ gems gems.wrappedRuby ];

  installPhase = ''
    mkdir -p $out
    cp -r . $out/
  '';

  meta = {
    description = "DevDocs packaged with bundlerEnv";
    platforms = ruby.meta.platforms;
  };
}
