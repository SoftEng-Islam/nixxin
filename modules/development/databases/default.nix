{ settings, lib, ... }:
let inherit (lib) optionals;
in {
  imports = optionals (settings.modules.development.databases.enable or false) [
    ./monogodb
    ./mysql
    ./postgresql
    ./sql
  ];
}
