{pkgs,...}:{
  environment.systemPackages = with pkgs; [
    # https://github.com/Kiro-Editor/Kiro
    kiro
  ];
}
