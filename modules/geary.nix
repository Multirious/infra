top: {
  configurations.homeManager.peach.use = m: [ m.geary ];

  flake.modules.homeManager.geary =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.geary
      ];
    };
}
