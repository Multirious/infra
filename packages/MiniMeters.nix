{
  pkgs,
  unzip,
  autoPatchelfHook,
  libx11,
  libxcursor,
  libxrandr,
  libxrender,
  libxkbcommon,
  openssl,
}:
let
  name = "MiniMeters";
  version = "1.0.29";
  minimeters = pkgs.stdenvNoCC.mkDerivation {
    inherit version name;
    src = pkgs.requireFile {
      name = "minimeters-linux.zip";
      sha256 = "1j62b27rnp9i3qcvakq1jkgi0kb7c0ip0pn6q2q1kql24yc3hx7b";
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
      openssl
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
