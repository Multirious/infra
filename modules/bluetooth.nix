top: {
  configurations.nixos.peach-asus.use = [ "bluetooth" ];

  flake.modules.nixos.bluetooth =
    { ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      services.blueman.enable = true;
    };
}
