top: {
  configurations.homeManager.peach.use = m: [ m.bottles ];

  flake.modules.homeManager.bottles =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.bottles
      ];
    };
}
