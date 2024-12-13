{
  home.file.".config/chrome-flags.conf" = {
    text = ''
      --enable-features=SomeFeature
      --disable-gpu
      --no-sandbox
    '';
    mode = "0644"; # Readable by everyone, writable by the user.
  };
}
