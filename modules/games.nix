top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.games
  ];

  flake.modules.homeManager.games =
    { config, pkgs, ... }:
    {
      home.packages =
        let
          steam = pkgs.steam.override {
            extraEnv.HOME = "${config.home.homeDirectory}/.local/share/steam";
          };
        in
        [
          steam
          # pkgs.prismlauncher
        ];
    };
}
