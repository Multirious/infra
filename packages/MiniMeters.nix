{
  pkgs,
  unzip,
  autoPatchelfHook,
  libx11,
  libxcursor,
  libxrandr,
  libxrender,
  libxkbcommon,
}:
let
  name = "MiniMeters";
  version = "1.0.22";
  minimeters = pkgs.stdenvNoCC.mkDerivation {
    inherit version name;
    src = pkgs.requireFile {
      name = "minimeters-linux.zip";
      sha256 = "0300n9l2sb3nsg7rbs5hzjxax41pqb7k7s9gnzpdq4x7402vll19";
      message = "This paid tool needed to be downloaded manually through itch.io";
    };
    buildInputs = [
      autoPatchelfHook
      unzip
      libx11
      libxcursor
      libxrandr
      libxrender
      libxkbcommon
    ];
    unpackPhase =
      # bash
      ''
        unzip $src
      '';
    installPhase =
      # bash
      ''
        mkdir -p $out/{bin,lib/{vst3,clap}/MiniMeters}
        mv MiniMeters-x86_64.AppImage $out/bin
        mv CLAP/* $out/lib/clap/MiniMeters
        mv VST3/* $out/lib/vst3/MiniMeters
      '';
  };
  minimetersAppimageWrapped = pkgs.appimageTools.wrapType2 {
    inherit version;
    pname = name;
    src = "${minimeters}/bin/MiniMeters-x86_64.AppImage";
    extraPkgs = pkgs: [ pkgs.libdecor ];
  };
in
pkgs.symlinkJoin {
  name = "MiniMeters";
  paths = [
    minimeters
    minimetersAppimageWrapped
  ];
  postBuild =
    # bash
    ''
      rm $out/bin/MiniMeters-x86_64.AppImage
    '';
}
