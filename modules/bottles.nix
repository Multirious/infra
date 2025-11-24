top: {
  configurations.homeManager.peach.use = [ "bottles" ];

  flake.modules.homeManager.bottles =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.bottles
      ];
    };
}
