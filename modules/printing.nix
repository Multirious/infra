top: {
  configurations.nixos.peach-asus.use = [ "printing" ];

  flake.modules.nixos.printing =
    { ... }:
    {
      services.printing.enable = true;
      hardware.sane.enable = true;
    };

}
