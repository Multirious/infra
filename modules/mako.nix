top: {
  homeManager.hyprland.use = [ "mako" ];
  homeManager.sway.use = [ "mako" ];

  homeManager.mako.module =
    { pkgs, ... }:
    {
      home.packages = [
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
