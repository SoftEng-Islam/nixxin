{ ... }: {
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/nixos"
    ];
  };
}
