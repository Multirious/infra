top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.archive
  ];

  flake.modules.homeManager.archive =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.zip
        pkgs.unzip
        pkgs.rar
        pkgs.p7zip
      ];
    };
}
