{ settings, pkgs, ... }: {
  # fonts.packages = [settings.fontPkg];
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      settings.fontPkg
      dejavu_fonts # Typeface family based on the Bitstream Vera fonts
      fira-code # Monospace font with programming ligatures
      mononoki # Font for programming and code review
      roboto # Roboto family of fonts
      # texlivePackages.fira # Fira fonts with LaTeX support
      font-awesome # Font Awesome - OTF font
      hack-font # Typeface designed for source code
      inter # Typeface specially designed for user interfaces
      noto-fonts # Beautiful and free fonts for many languages
      noto-fonts-emoji # Color emoji font
      noto-fonts-cjk
      google-fonts
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.style = "full";
      defaultFonts = {
        monospace = [ "JetBrains Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };
  environment.systemPackages = with pkgs;
    [
      fontconfig # Library for font customization and configuration
    ];
}
