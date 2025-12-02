top: {
  perSystem =
    { pkgs, ... }:
    {
      packages.openutau = pkgs.callPackage ../packages/openutau.nix { };
      packages.sitala = pkgs.callPackage ../packages/sitala.nix.nix { };
      packages.MiniMeters = pkgs.callPackage ../packages/MiniMeters.nix.nix { };
    };
}
