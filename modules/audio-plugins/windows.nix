top: {
  homeManager.audioPlugins.module =
    { pkgs, ... }:
    let
      manualPlugin =
        derivationName: requireName: sha256:
        pkgs.stdenvNoCC.mkDerivation {
          name = derivationName;
          src = pkgs.requireFile {
            name = "${requireName}";
            inherit sha256;
            message = "${requireName} needed to be added manually.";
          };
          nativeBuildInputs = [ pkgs.unzip ];
          unpackPhase = ''
            unzip $src
          '';
          installPhase = ''
            mkdir $out
            cp -r * $out
          '';
        };
      krush =
        manualPlugin "krush" "krush-windows.zip"
          "0swr3iv647k0zjsm0j6iz2pvnivxjk9bri4hcnqih7vcj4r6rljh";
      easy-strings =
        manualPlugin "easy-strings" "easy-strings-windows.zip"
          "0v6mbmcq90jgvgmgxyynkkzxix8vc7vjlmvd7sj9jqbzhqfv5i5h";
      valhalla-supermassive =
        manualPlugin "valhalla-supermassive" "valhalla-supermassive-windows.zip"
          "0cql2ck672p0c17kiq5iv5m136b900pn8hq89kc7q84wnbcpfzzs";
      keyzone-classic =
        manualPlugin "keyzone-classic" "keyzone-classic-windows.zip"
          "0hw362k8rhml2j36zyckm8s0cm9m15r9v8b1731xrqsry20awf3q";
    in
    {
      home.packages = [
        pkgs.yabridge
        pkgs.yabridgectl
      ];

      me.audio.windowsVst3File."Easy Strings.vst3".source = "${easy-strings}/Easy Strings.vst3";

      me.audio.windowsVstFile."Keyzone Classic.dll".source = "${keyzone-classic}/Keyzone Classic.dll";

      me.audio.windowsVst3File."Krush.vst3".source = "${krush}/Krush.vst3";

      me.audio.windowsVst3File."ValhallaSupermassive.vst3".source =
        "${valhalla-supermassive}/ValhallaSupermassive.vst3";
    };
}
