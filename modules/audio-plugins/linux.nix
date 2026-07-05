top: {
  homeManager.audioPlugins.module =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      myPackages = top.config.flake.packages."${system}";
    in
    {
      me.audio.vstFile."Vital.so".source = "${pkgs.vital}/lib/vst/Vital.so";
      me.audio.vst3File."Vital.vst3".source = "${pkgs.vital}/lib/vst3/Vital.vst3";
      me.audio.vstFile."libsitala.so".source = "${myPackages.sitala}/lib/vst/libsitala.so";
    };
}
