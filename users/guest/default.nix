{
  ...
}:
self:
{
  user.name = "Guest Account";
  user.username = "guest";
  user.email = "guest@example.com";

  system.hostName = "nixxin";
  system.architecture = "x86_64-linux";

  modules.users.uid = 1001;
  modules.users.managedGroups = [ "video" ];
  modules.users.extraGroups = [
    "audio"
    "networkmanager"
    "storage"
    "video"
  ];
}
