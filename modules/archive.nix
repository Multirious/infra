top: {
  configurations.homeManager.peach.use = m: [ m.archive ];

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
