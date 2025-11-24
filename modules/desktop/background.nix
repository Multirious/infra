top: {
  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.hyprpaper
      ];
      xdg.configFile."hypr/hyprpaper.conf".text =
        # hyprlang
        ''
          preload = ${./wallpapers/desert_lake.jpg}
          wallpaper = , ${./wallpapers/desert_lake.jpg}
        '';
    };
}
