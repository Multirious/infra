top: {
  configurations.homeManager.peach.use = m: [ m.audioEditing ];

  flake.modules.homeManager.audioEditing =
    { pkgs, ... }:
    {
      home.packages =
        let
          wine = pkgs.wineWowPackages.stableFull;
        in
        [
          pkgs.reaper
          pkgs.openutau
          (pkgs.yabridge.override { inherit wine; })
          (pkgs.yabridgectl.override { inherit wine; })
          wine
        ];

      home.file.".local/share/vst3/Vital.vst3".source = "${pkgs.vital}/lib/vst3/Vital.vst3";
      home.file.".local/share/vst/Vital.so".source = "${pkgs.vital}/lib/vst/Vital.so";
      # home.file.".local/share/vst/libsitala.so".source =
      #   let
      #     sitala = top.config.flake.packages."${pkgs.system}".sitala;
      #   in
      #   "${sitala}/lib/vst/libsitala.so";
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
