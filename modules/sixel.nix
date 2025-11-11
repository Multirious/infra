top: {
  configurations.homeManager.peach.use = m: [ m.sixel ];

  flake.modules.homeManager.sixel =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.lsix
        pkgs.libsixel
      ];
    };
}
