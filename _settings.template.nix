{ pkgs, ... }:
rec {
  # ---- Users ---- #
  # CHANGE THIS: Update the path to point to your user profile
  path = "/users/template/desktop/template"; # Path of the Profile
  profile = import (./. + path + "/default.nix") { inherit pkgs; };
}
