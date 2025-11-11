top: {
  configurations.homeManager.peach.use = m: [ m.games ];

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
