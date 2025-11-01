top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.bluetooth
  ];

  flake.modules.nixos.bluetooth =
    { ... }:
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      services.blueman.enable = true;
    };
}
