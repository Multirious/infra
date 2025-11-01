top: {
  flake.modules.homeManager.hyprland.imports = [
    top.config.flake.modules.homeManager.wofi
  ];

  flake.modules.homeManager.sway.imports = [
    top.config.flake.modules.homeManager.wofi
  ];

  flake.modules.homeManager.wofi =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.wofi
      ];
      home.file.".config/wofi/config".source = ./wofi/config;
      home.file.".config/wofi/style.css".source = ./wofi/style.css;
    };
}
