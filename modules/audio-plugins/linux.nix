top: {
  homeManager.audioPlugins.module =
    { pkgs, ... }:
    let
      myPkgs = top.config.flake.packages.${pkgs.stdenv.system};
    in
    {
      home.packages = [
        pkgs.vital
        myPkgs.sitala
        myPkgs.buffr
        myPkgs.polaar
        myPkgs.MiniMeters
      ];
    };
}
