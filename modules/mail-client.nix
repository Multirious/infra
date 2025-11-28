top: {
  configurations.homeManager.peach.use = [ "mailClient" ];

  homeManager.mailClient.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.geary
      ];
    };
}
