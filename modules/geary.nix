top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.geary
  ];

  flake.modules.homeManager.geary =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.geary
      ];
    };
}
