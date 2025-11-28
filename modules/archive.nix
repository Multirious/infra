top: {
  # configurations.homeManager.peach.use = [ "archive" ];

  homeManager.archive.module =
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
