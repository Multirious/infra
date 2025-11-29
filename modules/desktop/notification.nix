top: {
  nixos.battery.module =
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
  homeManager.desktop.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.fyi
        pkgs.libnotify
        pkgs.mako
      ];

      xdg.configFile."mako/config".text =
        # ini
        ''
          default-timeout=30000
          max-history=20
          sort=+time

          anchor=bottom-right
          font=monospace 11
          text-color=#222222
          background-color=#EEEEEE
          border-size=0
          border-radius=10
          outer-margin=0,0,5
        '';

    };
}
