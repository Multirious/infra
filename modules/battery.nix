top: {
  flake.modules.nixos.laptop.imports = [
    top.config.flake.modules.nixos.battery
  ];

  flake.modules.nixos.battery =
    { config, pkgs, lib, ... }:
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

        systemd.user.timers."battery-alert" = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnBootSec = "5m";
            OnUnitActiveSec = "5m";
            Unit = "battery-alert.service";
          };
        };
        systemd.user.services."battery-alert" = {
          script = ''
            battery_path="/sys/class/power_supply/${cfg.label}"
            ac_path="/sys/class/power_supply/ACAD"
            battery_percentage=$((
              $(cat "$battery_path/charge_now") * 100 / $(cat "$battery_path/charge_full")
            ))
            ac_online=$(cat "$ac_path/online")
            if [ $battery_percentage -le 20 ] && [ $ac_online -ne 1 ]; then
              ${pkgs.fyi}/bin/fyi \
                --urgency=critical \
                "The battery has $battery_percentage% left"
            fi
          '';
          serviceConfig = {
            Type = "oneshot";
          };
        };
      };
    };
}
