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
          "047sk4zvzyjd10nr6bsqhgcpvw7g2jk7fgbwmijpzjspxa5xi35r";
      easy-strings =
        manualPlugin "easy-strings" "easy-strings-windows.zip"
          "14il71is7fb2rmk0rrs3kq5ikrh26vnswp7dlhbg28jdzn32xyjg";
      valhalla-supermassive =
        manualPlugin "valhalla-supermassive" "valhalla-supermassive-windows.zip"
          "0xikfjyrcvl5rg60qhg7ri7r20kjmvlip4q9i59y0zqd8csj004a";
      keyzone-classic =
        manualPlugin "keyzone-classic" "keyzone-classic-windows.zip"
          "16hnq3c541yl8na89m253kxq3p8lfjz7bgvbh1b0qlf1d2546ph4";
    in
    {
      home.packages = [
        pkgs.yabridge
        pkgs.yabridgectl
      ];

      me.audio.windowsVst3File."Easy Strings.vst3".source = "${easy-strings}/Easy Strings.vst3";
      me.audio.windowsVst3File."Easy Strings.instruments".source =
        "${easy-strings}/Easy Strings.instruments";

      me.audio.windowsVstFile."Keyzone Classic.dll".source = "${keyzone-classic}/Keyzone Classic.dll";
      me.audio.windowsVstFile."Keyzone Classic.instruments".source =
        "${keyzone-classic}/Keyzone Classic.instruments";

      me.audio.windowsVst3File."Krush.vst3".source = "${krush}/Krush.vst3";

      me.audio.windowsVst3File."ValhallaSupermassive.vst3".source =
        "${valhalla-supermassive}/ValhallaSupermassive.vst3";
    };
}
