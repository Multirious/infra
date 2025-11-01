top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.bottles
  ];

  flake.modules.homeManager.bottles =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.bottles
      ];
    };
}
