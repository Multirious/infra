top: {
  configurations.nixos.peach-asus.module =
    { ... }:
    {
      environment.etc."wireplumber/wireplumber.conf.d".source = ./wireplumber.conf.d;
    };
}
