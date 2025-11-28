top: {
  configurations.homeManager.peach.use = [ "sixel" ];

  homeManager.sixel.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.lsix
        pkgs.libsixel
      ];
    };
}
