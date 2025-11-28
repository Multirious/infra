top: {
  configurations.nixos.peach-asus.use = [ "docker" ];
  configurations.nixos.peach-asus.module =
    { ... }:
    {
      users.users.peach.extraGroups = [ "docker" ];
    };

  nixos.docker.module =
    { ... }:
    {
      virtualisation.docker.enable = true;
    };
}
