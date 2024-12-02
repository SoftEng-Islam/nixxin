{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      fira-code # Monospace font with programming ligatures
      jetbrains-mono # Typeface made for developers
      mononoki # Font for programming and code review
      roboto # Roboto family of fonts

      # # texlivePackages.fira # Fira fonts with LaTeX support

      font-awesome # Font Awesome - OTF font
      hack-font # Typeface designed for source code
      inter # Typeface specially designed for user interfaces
      noto-fonts # Beautiful and free fonts for many languages
      noto-fonts-emoji # Color emoji font

      # nerd-fonts.fira-code # Nerd Fonts: Programming ligatures, extension of Fira Mono font, enlarged operators
      # nerd-fonts.jetbrains-mono # Nerd Fonts: JetBrains officially created font for developers
      # nerd-fonts.monaspace # Nerd Fonts: Five matching fonts all having 'texture healing' to improve legibility
      # nerd-fonts.mononoki # Nerd Fonts: Keeps in mind differentiation of characters and resolution sizes
      # nerd-fonts.noto # Nerd Fonts: `0` and `O` very similar, characters are either very curvy or straight lined
      # nerd-fonts.roboto-mono
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
  environment.systemPackages = with pkgs; [
    fontconfig # Library for font customization and configuration
  ];
}
