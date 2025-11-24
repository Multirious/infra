top: {
  configurations.homeManager.peach.use = [ "mailClient" ];

  flake.modules.homeManager.mailClient =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.geary
      ];
    };
}
