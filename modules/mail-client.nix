top: {
  configurations.homeManager.peach.use = m: [ m.mailClient ];

  flake.modules.homeManager.mailClient =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.geary
      ];
    };
}
