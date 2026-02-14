{ pkgs }:
{
  openutau = pkgs.callPackage ./openutau.nix { };
  sitala = pkgs.callPackage ./sitala.nix { };
  MiniMeters = pkgs.callPackage ./MiniMeters.nix { };
  reaper = pkgs.callPackage ./reaper.nix {
    jackLibrary = pkgs.pipewire.jack;
    ffmpeg = pkgs.ffmpeg_4-headless;
  };
}
