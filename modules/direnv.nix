top: {
  configurations.homeManager.peach.use = [ "direnv" ];

  homeManager.direnv.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.direnv
      ];
      xdg.configFile."direnv/direnv.toml".text = ''
        hide_env_diff = true
      '';
    };
}
