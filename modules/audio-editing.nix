top: {
  configurations.homeManager.peach.use = m: [ m.audioEditing ];

  flake.modules.homeManager.audioEditing =
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
      config = {
        home.packages =
          let
            wine = pkgs.wineWowPackages.stableFull;
          in
          [
            top.config.flake.packages."${pkgs.stdenv.hostPlatform.system}".openutau
            pkgs.reaper
            (pkgs.yabridge.override { inherit wine; })
            (pkgs.yabridgectl.override { inherit wine; })
            wine
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

  flake.modules.nixos.audioEditing =
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
