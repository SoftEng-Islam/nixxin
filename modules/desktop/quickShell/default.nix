{ settings, inputs, lib, pkgs, ... }:
let
  quickshell-wrapped = pkgs.runCommand "quickshell" {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${
      inputs.quickshell.packages.${pkgs.system}.default
    }/bin/qs $out/bin/qs \
      --prefix QT_PLUGIN_PATH : "${pkgs.qt6.qtbase}/${pkgs.qt6.qtbase.qtPluginPrefix}" \
      --prefix QT_PLUGIN_PATH : "${pkgs.qt6.qt5compat}/${pkgs.qt6.qtbase.qtPluginPrefix}" \
      --prefix QML2_IMPORT_PATH : "${pkgs.qt6.qt5compat}/${pkgs.qt6.qtbase.qtQmlPrefix}" \
      --prefix QML2_IMPORT_PATH : "${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}" \
      --prefix PATH : ${lib.makeBinPath [ pkgs.fd pkgs.coreutils ]}
  '';

in {
  # git clone https://github.com/Shanu-Kumawat/quickshell-overview ~/.config/quickshell/overview

  home-manager.users.${settings.user.username} = {
    home.file."~/.config/quickshell/overview".source = ./overview;
  };

  environment.systemPackages = with pkgs; [
    quickshell-wrapped
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtmultimedia
    kdePackages.qt5compat
    qt6.qt5compat
    qt6.qtdeclarative
  ];
}
