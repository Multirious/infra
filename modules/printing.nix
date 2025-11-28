top: {
  configurations.nixos.peach-asus.use = [ "printing" ];

  nixos.printing.module =
    { ... }:
    {
      services.printing.enable = true;
      hardware.sane.enable = true;
    };

}
