{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code # Monospace font with programming ligatures
      jetbrains-mono # Typeface made for developers
      mononoki # Font for programming and code review
      roboto # Roboto family of fonts
      # texlivePackages.fira # Fira fonts with LaTeX support
      font-awesome # Font Awesome - OTF font
      hack-font # Typeface designed for source code
      inter # Typeface specially designed for user interfaces
      noto-fonts # Beautiful and free fonts for many languages
      noto-fonts-emoji # Color emoji font
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
