{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # Python library for audio and music analysis
    python314Packages.librosa
    essentia-extractor
  ];
}
