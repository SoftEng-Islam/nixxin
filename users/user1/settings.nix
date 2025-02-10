{ pkgs, ... }: rec {
  softeng = {
    name = "Islam Ahmed";
    username = "softeng";
    email = "softeng.islam@gmail.com";
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
