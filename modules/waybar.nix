top: {
  flake.modules.homeManager.hyprland.imports = [
    top.config.flake.modules.homeManager.waybar
  ];

  flake.modules.homeManager.sway.imports = [
    top.config.flake.modules.homeManager.waybar
  ];

  flake.modules.homeManager.waybar =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.waybar
      ];
      home.file.".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
      home.file.".config/waybar/style.css".source = ./waybar/style.css;
      home.file.".config/waybar/mediaplayer.py".source = ./waybar/mediaplayer.py;
      home.file.".config/waybar/power_menu.xml".source = ./waybar/power_menu.xml;
    };
}
