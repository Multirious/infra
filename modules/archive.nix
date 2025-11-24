top: {
  configurations.homeManager.peach.use = [ "archive" ];

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
