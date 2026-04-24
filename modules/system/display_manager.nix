# Display/Login manager
{
  settings,
  lib,
  pkgs,
  ...
}:
let
  sddmAstronautBase =
    if pkgs ? sddm-astronaut then
      pkgs.sddm-astronaut
    else
      pkgs.stdenvNoCC.mkDerivation {
        pname = "sddm-astronaut-theme";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "Keyitdev";
          repo = "sddm-astronaut-theme";
          rev = "master";
          hash = lib.fakeHash;
        };
        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/sddm/themes
          cp -R . $out/share/sddm/themes/sddm-astronaut-theme
          runHook postInstall
        '';
      };

  sddmAstronautBlackHole = sddmAstronautBase.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      substituteInPlace "$out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop" \
        --replace-fail "ConfigFile=Themes/astronaut.conf" "ConfigFile=Themes/black_hole.conf"
    '';
  });

  qtMultimedia =
    if pkgs ? kdePackages && pkgs.kdePackages ? qtmultimedia then
      pkgs.kdePackages.qtmultimedia
    else if pkgs ? qt6 && pkgs.qt6 ? qtmultimedia then
      pkgs.qt6.qtmultimedia
    else
      null;

  qtVirtualKeyboard =
    if pkgs ? kdePackages && pkgs.kdePackages ? qtvirtualkeyboard then
      pkgs.kdePackages.qtvirtualkeyboard
    else if pkgs ? qt6 && pkgs.qt6 ? qtvirtualkeyboard then
      pkgs.qt6.qtvirtualkeyboard
    else
      null;

  qtSvg =
    if pkgs ? kdePackages && pkgs.kdePackages ? qtsvg then
      pkgs.kdePackages.qtsvg
    else if pkgs ? qt6 && pkgs.qt6 ? qtsvg then
      pkgs.qt6.qtsvg
    else
      null;

  sddmAstronautDeps =
    lib.optionals (qtMultimedia != null) [ qtMultimedia ]
    ++ lib.optionals (qtVirtualKeyboard != null) [ qtVirtualKeyboard ]
    ++ lib.optionals (qtSvg != null) [ qtSvg ];
in
{
  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  environment.systemPackages = [ sddmAstronautBlackHole ] ++ sddmAstronautDeps;

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddmAstronautBlackHole ] ++ sddmAstronautDeps;
    settings = {
      Theme = {
        CursorTheme = settings.common.cursor.name;
        CursorSize = settings.common.cursor.size;
      };
    };
  };

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession = "hyprland";

  # ---- XSERVER ---- #
  services.xserver.enable = true;
  services.xserver.autorun = true;
}
