top: {
  flake.modules.nixos.laptop.imports = [
    top.config.flake.modules.nixos.battery
  ];

  flake.modules.nixos.battery =
    { config, lib, ... }:
    let
      cfg = config.me.battery;
    in
    {
      options.me.battery.label = lib.mkOption {
        type = lib.types.str;
        example = "BAT1";
        description = "The system battery label such as \"BAT1\" from \"/sys/class/power_supply/BAT1\"";
      };
      options.me.battery.startChargeThreshold = lib.mkOption {
        type = lib.types.ints.between 0 100;
        example = "50";
        description = "Minimum battery charge threshold";
      };
      options.me.battery.stopChargeThreshold = lib.mkOption {
        type = lib.types.ints.between 0 100;
        example = "60";
        description = "Maximum battery charge threshold";
      };
      config = {
        services.tlp.settings = {
          "START_CHARGE_THRESH_${cfg.label}" = cfg.startChargeThreshold;
          "STOP_CHARGE_THRESH_${cfg.label}" = cfg.stopChargeThreshold;
        };
      };
    };
}
