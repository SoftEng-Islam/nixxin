{ pkgs, inputs, ... }:

let
  inherit (pkgs) lib;

  releases = lib.genAttrs [
    "photocraft"
    "vectorcraft"
    "filmcraft"
    "lightcraft"
    "effectcraft"
    "designcraft"
    "figcraft"
    "soundcraft"
    "wordcraft"
    "pdfcraft"
    "deckcraft"
    "cadcraft"
    "gridcraft"
  ] (name: builtins.fromJSON (builtins.readFile inputs."${name}-release"));

  # Upstream's native Linux tarballs include the GUI, CLI/MCP tools, desktop
  # entries, icons and MIME definitions. Release metadata is pinned in
  # flake.lock; `nix flake update` refreshes versions and archive checksums.
  # Catalog: https://getartcraft.com/apps
  runtimeLibraries = with pkgs; [
    libxkbcommon
    libx11
    libxcb
    libxcursor
    libxi
    libxrandr
    wayland
    vulkan-loader
    libGL
    dbus
    fontconfig
    freetype
  ];

  audioApps = [
    "filmcraft"
    "effectcraft"
    "soundcraft"
    "deckcraft"
  ];

  mkCraft =
    name: release:
    let
      version = lib.removePrefix "v" release.tag_name;
      archiveName = "${name}-${version}-linux-x86_64.tar.gz";
      archive = lib.findFirst (
        asset: asset.name == archiveName
      ) (throw "${name}: release ${release.tag_name} has no ${archiveName}") release.assets;
      appLibraries =
        runtimeLibraries
        ++ lib.optionals (builtins.elem name audioApps) [ pkgs.alsa-lib ]
        ++ lib.optionals (name == "filmcraft") [ pkgs.libva ];
    in
    pkgs.stdenv.mkDerivation {
      pname = name;
      inherit version;

      src = pkgs.fetchurl {
        url = archive.browser_download_url;
        hash = archive.digest; # "sha256:<hex>" is accepted as-is
      };

      # Tarball may extract bin/ and share/ at top level instead of in a subdir
      sourceRoot = ".";

      nativeBuildInputs = [ pkgs.autoPatchelfHook ];
      buildInputs = appLibraries ++ [ pkgs.stdenv.cc.cc.lib ];
      # winit, wgpu and file dialogs load these with dlopen, not DT_NEEDED.
      runtimeDependencies = map lib.getLib appLibraries;
      dontBuild = true;
      dontStrip = true;

      installPhase = ''
        runHook preInstall
        mkdir -p "$out"
        cp -r bin share "$out/"
        runHook postInstall
      '';

      meta = {
        description = "${name} from the ArtCraft Crafting Apps suite";
        homepage = "https://getartcraft.com/apps/${name}";
        sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
        license = [
          lib.licenses.mit
          lib.licenses.asl20
        ];
        platforms = [ "x86_64-linux" ];
        mainProgram = name;
      };
    };
in
lib.mapAttrs mkCraft releases
