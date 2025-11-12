top: {
  flake.modules.nixos.battery =
    { config, pkgs, ... }:
    {
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
          battery_path="/sys/class/power_supply/${config.me.battery.label}"
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
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.fyi
        pkgs.libnotify
      ];
    };
}
