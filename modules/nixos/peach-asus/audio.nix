top: {
  configuration.nixos.peach-asus.module =
    { ... }:
    {
      environment.etc."wireplumber/wireplumber.conf.d".source = ./wireplumber.conf.d;
    };
}
