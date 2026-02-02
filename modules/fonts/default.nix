{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.fonts.enable) {
  #.Sometimes cached data or corrupt configuration files cause issues.
  # rm -rf ~/.cache/fontconfig && rm -rf ~/.config/ibus && fc-cache -fv
  fonts = {
    enableDefaultPackages = false;
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
      noto-fonts-color-emoji # Color emoji font

      # ---- Nerd Fonts ---- #
      nerd-fonts.caskaydia-cove

      # Arabic Fonts
      amiri
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      subpixel.rgba = "rgb"; # Subpixel rendering
      cache32Bit = true;
      hinting.enable = true;
      hinting.style = settings.modules.fonts.main.hinting;
      useEmbeddedBitmaps = true; # for better rendering of Calibri like fonts

      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "${settings.modules.fonts.serif.name}" ];
        sansSerif = [ "${settings.modules.fonts.sansSerif.name}" ];
        monospace = [ "${settings.modules.fonts.monospace.name}" ];
      };
    };
  };
  environment.variables = {
    # FONTCONFIG_PATH = "/etc/fonts";
    # FONTCONFIG_FILE = "/etc/fonts/fonts.conf";
  };
  # Console fonts
  # Configure Virtual Console
  console = {
    enable = true;
    # Relevant for both X11 and Wayland:
    earlySetup = false;
    # Still useful for:
    # - Early boot debugging
    # - Recovery shell keyboard support
    # - TTY console functionality
    # NOTE: setting it to flase might give slightly faster boot (micro-optimization)

    # Only affects virtual consoles (TTYs), not Wayland:
    useXkbConfig = true;
    # Can safely keep enabled because:
    # 1. Doesn't interfere with Wayland compositors
    # 2. Maintains proper keyboard layout in:
    #    - Emergency TTY sessions
    #    - Login prompts
    #    - Systemd services needing console

    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    # useXkbConfig = false; # If set, configure the virtual console keymap from the xserver keyboard settings.
    colors = [
      "1e1e2e" # Black
      "f38ba8" # Red
      "a6e3a1" # Green
      "f9e2af" # Yellow
      "89b4fa" # Blue
      "cba6f7" # Magenta
      "94e2d5" # Cyan
      "cdd6f4" # White
      "585b70" # Bright Black
      "f38ba8" # Bright Red
      "a6e3a1" # Bright Green
      "f9e2af" # Bright Yellow
      "89b4fa" # Bright Blue
      "cba6f7" # Bright Magenta
      "94e2d5" # Bright Cyan
      "a6adc8" # Bright White
    ];
  };
  environment.systemPackages = with pkgs; [
    font-manager
    fontconfig # Library for font customization and configuration
    # fribidi
  ];
}
