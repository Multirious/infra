top: {
  configurations.homeManager.peach.use = m: [ m.audioProduction ];

  flake.modules.homeManager.audioProduction =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      options =
        let
          filesOption = lib.types.lazyAttrsOf (
            lib.types.submodule {
              options = {
                source = lib.mkOption {
                  type = lib.types.oneOf [
                    lib.types.package
                    lib.types.path
                  ];
                };
              };
            }
          );
        in
        {
          me.audio.vstFile = lib.mkOption { type = filesOption; };
          me.audio.vst3File = lib.mkOption { type = filesOption; };
        };
      config =
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

          xdg.dataFile =
            (lib.mapAttrs' (path: value: {
              name = "vst/" + path;
              value = value;
            }) config.me.audio.vstFile)
            // (lib.mapAttrs' (path: value: {
              name = "vst3/" + path;
              value = value;
            }) config.me.audio.vst3File);
        };
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
