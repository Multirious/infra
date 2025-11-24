top: {
  configurations.homeManager.peach.use = [ "sixel" ];

  flake.modules.homeManager.sixel =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.lsix
        pkgs.libsixel
      ];
    };
}
