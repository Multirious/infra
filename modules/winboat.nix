top: {
  configurations.homeManager.peach.use = [ "winboat" ];

  homeManager.winboat.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.winboat
      ];
    };
}
