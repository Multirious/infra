top: {
  configurations.homeManager.peach.use = [ "audioProduction" ];
  configurations.nixos.peach-asus.use = [ "audioProduction" ];

  flake.modules.homeManager.audioProduction =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      home.packages =
        let
          nixpkgsWithReaper = pkgs.fetchFromGitHub {
            owner = "r-ryantm";
            repo = "nixpkgs";
            rev = "aefc6bae9e00e46b805ff36c50612199d64f38e8";
            hash = "sha256-zXwHmaEHAbwgibPDHspOOH96ULj+DjZ3kliQV3biGnU=";
          };
          reaper =
            (import nixpkgsWithReaper {
              config.allowUnfree = true;
              inherit system;
            }).reaper;
        in
        [
          top.config.flake.packages."${system}".openutau
          reaper
        ];
    };

  flake.modules.nixos.audioProduction =
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
