{
  lib,
  stdenv,
  requireFile,
  makeWrapper,
  unzip,
  libgcc,
  libx11,
  alsa-lib,
}:
stdenv.mkDerivation (final: {
  pname = "buffr";
  version = "0.4.26";
  src = requireFile rec {
    name = "${final.pname}-linux-${final.version}.zip";
    sha256 = "0njg04azi6i1m4p3b0arbr7pxpbkhvmfx48d0964b73kmjbmcbwy";
    message = "${name} needed to be add manually";
  };
  nativeBuildInputs = [
    unzip
    makeWrapper
  ];
  buildInputs = [
    libgcc
    libx11
    alsa-lib
  ];
  unpackPhase = ''
    unzip $src
  '';
  installPhase = ''
    mkdir -p $out/lib/{vst3,clap}
    cp -r BUFFR.vst3 $out/lib/vst3
    cp -r BUFFR.clap $out/lib/clap
  '';
  postFixup = ''
    patchelf $out/lib/vst3/BUFFR.vst3/Contents/x86_64-linux/BUFFR.so \
      --set-rpath ${lib.makeLibraryPath final.buildInputs}
  '';
})
