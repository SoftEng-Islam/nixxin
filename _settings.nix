{ pkgs, ... }: rec {
  # ---- Users ---- #
  path = "/users/softeng/desktop/HP"; # Path of the Profile
  profile = import (./. + path + "/default.nix") { inherit pkgs; };
}
