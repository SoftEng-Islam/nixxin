{pkgs, ...}: let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "c0ad8a3c995e2e71c471515b9cf17d68c8425fd7";
    hash = "sha256-WC/5FNzZiGxl9HKWjF+QMEJC8RXqT8WtOmjVH6kBqaY=";
  };
in {
  chmod = "${yazi-plugins}/chmod.yazi";
  full-border = "${yazi-plugins}/full-border.yazi";
  toggle-pane = "${yazi-plugins}/toggle-pane.yazi";

  starship = pkgs.fetchFromGitHub {
    owner = "rolv-apneseth";
    repo = "starship.yazi";
    rev = "428d43ac0846cb1885493a1f01c049a883b70155";
    hash = "sha256-YkDkMC2SJIfpKrt93W/v5R3wOrYcat7QTbPrWqIKXG8=";
  };
  glow = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "2da96e3ffd9cd9d4dd53e0b2636f83ff69fe9af0";
    hash = "sha256-4krck4U/KWmnl32HWRsblYW/biuqzDPysrEn76buRck=";
  };
  nbpreview = pkgs.fetchFromGitHub {
    owner = "AnirudhG07";
    repo = "nbpreview.yazi";
    rev = "f8879b382f441e881fc10bd18a523fd910737067";
    hash = "sha256-iHfvLSUveHSRvYw5xFGuhSsTRC3xlY+PaooHnmA7Zzs=";
  };
  miller = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "miller.yazi";
    rev = "40e02654725a9902b689114537626207cbf23436";
    hash = "sha256-GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
  };
}
