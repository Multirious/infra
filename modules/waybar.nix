top: {
  flake.modules.homeManager.hyuse = m: [ m.waybar ];

  flake.modules.homeManager.sway.imports = [
    top.config.flake.modules.homeManager.waybar
  ];

  flake.modules.homeManager.waybar =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.waybar
      ];
      home.file.".local/config/waybar/config.jsonc".source = ./waybar/config.jsonc;
      home.file.".local/config/waybar/style.css".source = ./waybar/style.css;
      home.file.".local/config/waybar/mediaplayer.py".source = ./waybar/mediaplayer.py;
      home.file.".local/config/waybar/power_menu.xml".source = ./waybar/power_menu.xml;
    };
}
