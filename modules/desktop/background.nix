top: {
  homeManager.hyprland.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.hyprpaper
      ];
      xdg.configFile."hypr/hyprpaper.conf".text =
        # hyprlang
        ''
          splash = false
          wallpaper {
            monitor = eDP-1
            path = ${./wallpapers/desert_lake.jpg}
          }
          wallpaper {
            monitor = HDMI-A-1
            path = ${./wallpapers/desert_lake.jpg}
          }
        '';
    };
}
