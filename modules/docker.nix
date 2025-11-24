top: {
  configurations.nixos.peach-asus.use = [ "docker" ];
  configurations.nixos.peach-asus.module =
    { ... }:
    {
      users.users.peach.extraGroups = [ "docker" ];
    };

  flake.modules.nixos.docker =
    { ... }:
    {
      virtualisation.docker.enable = true;
    };
}
