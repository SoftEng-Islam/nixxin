{
  home.file.".config/chrome-flags.conf" = {
    text = ''
      --enable-features=SomeFeature
      --disable-gpu
      --no-sandbox
    '';
  };
}
