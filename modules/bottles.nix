top: {
  configurations.homeManager.peach.use = [ "bottles" ];

  homeManager.bottles.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.bottles
      ];
    };
}
