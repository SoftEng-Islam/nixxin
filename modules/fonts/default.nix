{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.fonts.enable) {
  #. Sometimes cached data or corrupt configuration files cause issues.
  # rm -rf ~/.cache/fontconfig && rm -rf ~/.config/ibus && fc-cache -fv
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      # ---- Main Font ---- #
      settings.modules.fonts.main.package
      monaspace
      jetbrains-mono

      # ---- Extra Fonts ---- #
      fira-code # Monospace font with programming ligatures
      texlivePackages.fira # Fira fonts with LaTeX support

      # ---- Noto Fonts ---- #
      noto-fonts # Beautiful and free fonts for many languages
      noto-fonts-emoji # Color emoji font
      noto-fonts-extra # Includes Arabic

      # ---- Nerd Fonts ---- #
      nerd-fonts.caskaydia-cove

      # Arabic Fonts
      amiri
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.style = settings.modules.fonts.main.hinting;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "${settings.modules.fonts.serif.name}" ];
        sansSerif = [ "${settings.modules.fonts.sansSerif.name}" ];
        monospace = [ "${settings.modules.fonts.monospace.name}" ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    font-manager
    fontconfig # Library for font customization and configuration
    fribidi
  ];
}
