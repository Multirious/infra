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
          preload = /home/peach/.local/share/backgrounds/desert_lake.jpg
          wallpaper = , /home/peach/.local/share/backgrounds/desert_lake.jpg
        '';
    };
}
