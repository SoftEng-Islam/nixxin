{ pkgs, ... }: rec {
  # ---- Users ---- #
  path = "/users/user1/desktop"; # Path of the Profile
  profile = import (./. + path + "/default.nix") { inherit pkgs; };
}
