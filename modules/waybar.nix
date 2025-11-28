top: {
  homeManager.hyprland.use = [ "waybar" ];
  homeManager.sway.use = [ "waybar" ];

  homeManager.waybar.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.waybar
      ];
      xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
      xdg.configFile."waybar/style.css".source = ./waybar/style.css;
      xdg.configFile."waybar/mediaplayer.py".source = ./waybar/mediaplayer.py;
      xdg.configFile."waybar/power_menu.xml".source = ./waybar/power_menu.xml;
    };
}
