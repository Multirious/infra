top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.sixel
  ];

  flake.modules.homeManager.sixel =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.lsix
        pkgs.libsixel
      ];
    };
}
