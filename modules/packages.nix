top: {
  perSystem =
    { pkgs, ... }:
    {
      packages.openutau = pkgs.calPackage ../packages/openutau.nix { };
      packages.sitala = pkgs.calPackage ../packages/sitala.nix.nix { };
      packages.MiniMeters = pkgs.calPackage ../packages/MiniMeters.nix.nix { };
    };
}
