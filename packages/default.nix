{ pkgs }:
{
  openutau = pkgs.callPackage ./openutau.nix { };
  sitala = pkgs.callPackage ./sitala.nix { };
  MiniMeters = pkgs.callPackage ./MiniMeters.nix { };
}
