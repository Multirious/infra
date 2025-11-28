top: {
  configurations.nixos.peach-asus.use = [ "bluetooth" ];

  nixos.bluetooth.module =
    { ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      services.blueman.enable = true;
    };
}
