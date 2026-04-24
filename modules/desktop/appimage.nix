{
  pkgs,
  ...
}:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      # Extra libraries and packages for Appimage run
      extraPkgs =
        pkgs: with pkgs; [
          ffmpeg
          imagemagick
        ];
    };
  };
}
