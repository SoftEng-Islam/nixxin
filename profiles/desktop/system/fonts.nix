{ mySettings, pkgs, ... }: {
  #. Sometimes cached data or corrupt configuration files cause issues.
  # rm -rf ~/.cache/fontconfig
  # fc-cache -fv
  # rm -rf ~/.config/ibus

  # fonts.packages = [mySettings.fontPackage];
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      mySettings.fontPackage
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
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
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
