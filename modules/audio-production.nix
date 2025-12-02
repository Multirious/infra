top: {
  configurations.homeManager.peach.use = [ "audioProduction" ];
  configurations.nixos.peach-asus.use = [ "audioProduction" ];

  homeManager.audioProduction.module =
    { config, pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      home.packages = [
        top.config.flake.packages."${system}".openutau
        (pkgs.linkFarm "MiniMetersBin" [
          {
            name = "bin/MiniMeters";
            path = "${top.config.flake.packages."${system}".MiniMeters}/bin/MiniMeters";
          }
        ])
        pkgs.reaper
      ];
    };

  nixos.audioProduction.module =
    { ... }:
    {
      security.pam.loginLimits = [
        {
          domain = "@audio";
          item = "rtprio";
          type = "-";
          value = "95";
        }
        {
          domain = "@audio";
          item = "memlock";
          type = "-";
          value = "unlimited";
        }
      ];
    };
}
