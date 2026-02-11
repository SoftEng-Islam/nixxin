{ lib, python3Packages, fetchFromGitHub, meson, ninja, pkg-config
, blueprint-compiler, gobject-introspection, wrapGAppsHook4, desktop-file-utils
, libadwaita, libglycin, libva-utils, ffmpeg, gst_all_1, glycin-loaders,
}:

python3Packages.buildPythonApplication rec {
  pname = "constrict";
  version = "25.12.1";
  pyproject = false; # Built with meson

  src = fetchFromGitHub {
    owner = "Wartybix";
    repo = "Constrict";
    tag = version;
    hash = "sha256-ZSiBlejNFakz+/3qj3n+ekB5l9JOk3MiQ8PRZOdxtLQ=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    blueprint-compiler
    gobject-introspection
    wrapGAppsHook4
    desktop-file-utils
  ];

  buildInputs = [ libadwaita libglycin ];

  dependencies = [ python3Packages.pygobject3 ];

  # Search for use of subprocess
  runtimeDeps = [
    libva-utils
    ffmpeg
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=(
      ''${gappsWrapperArgs[@]}
      --prefix XDG_DATA_DIRS : "${glycin-loaders}/share"
      --prefix PATH : ${lib.makeBinPath runtimeDeps}
      # Constrict uses VA-API (via ffmpeg + vainfo). On NixOS the driver lives
      # under /run/opengl-driver, and some setups don't have card0 so vainfo's
      # implicit DRM device selection can fail.
      #
      # Use defaults that can still be overridden by the user/session.
      --set-default LIBVA_DRM_DEVICE /dev/dri/renderD128
      --set-default LIBVA_DRIVERS_PATH /run/opengl-driver/lib/dri
      --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib
    )
  '';

  postInstall = ''
    # Respect LIBVA_DRM_DEVICE at runtime and make the HA capability check use
    # the same device as the encoder path.
    substituteInPlace "$out/share/constrict/constrict/constrict_utils.py" \
      --replace \
        "cmd = ['vainfo', '--display', 'drm']" \
        "cmd = ['vainfo', '--display', 'drm', '--device', os.environ.get('LIBVA_DRM_DEVICE', '/dev/dri/renderD128')]" \
      --replace \
        "pass1_cmd.extend(['-vaapi_device', '/dev/dri/renderD128'])" \
        "pass1_cmd.extend(['-vaapi_device', os.environ.get('LIBVA_DRM_DEVICE', '/dev/dri/renderD128')])" \
      --replace \
        "pass2_cmd.extend(['-vaapi_device', '/dev/dri/renderD128'])" \
        "pass2_cmd.extend(['-vaapi_device', os.environ.get('LIBVA_DRM_DEVICE', '/dev/dri/renderD128')])"
  '';

  meta = {
    description = "Compresses your videos to your chosen file size";
    homepage = "https://github.com/Wartybix/Constrict";
    changelog =
      "https://github.com/Wartybix/Constrict/releases/tag/${version}";
    license = lib.licenses.gpl3Plus;
    mainProgram = "constrict";
    teams = [ lib.teams.gnome-circle ];
    platforms = lib.platforms.linux;
  };
}
