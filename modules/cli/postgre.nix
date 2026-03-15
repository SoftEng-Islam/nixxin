{pkgs, ...}: {
  home.packages = with pkgs; [
    postgresql
    pgadmin
  ];
}
