{ pkgs, ... }: rec {
  user = {

    name = "Islam Ahmed"; # Name/Identifier
    username = "softeng"; # Username
    email = "softeng.islam@gmail.com"; # Email (git config)
    devices = {
      desktop = {
        system = {
          hostname = "nixos";
          architecture = "x86_64-linux";
          stateVersion = "24.05";
        };
        home = { };
        language = { };
      };
      laptop = { };
    };
  };
}
