top: {
  configurations.homeManager.peach.use = [ "audioProduction" ];
  configurations.nixos.peach-asus.use = [ "audioProduction" ];

  homeManager.audioProduction.module =
    { config, pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      # minimeters = pkgs.callPackage ../packages/MiniMeters.nix {
      #   apiKeyPath = config.sops.secrets.itchio_api_key.path;
      # };
    in
    {
      home.packages = [
        top.config.flake.packages."${system}".openutau
        pkgs.reaper
        # minimeters
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
