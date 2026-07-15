{
  stdenv,
  requireFile,
  makeWrapper,
  unzip,
}:
stdenv.mkDerivation (final: {
  pname = "polaar";
  version = "0.3.126";
  src = requireFile rec {
    name = "${final.pname}-linux-${final.version}.zip";
    sha256 = "0z9rpapq2ldjsn7smnb9wijjpsi5nb7bcm242mn18disg7rpw1yr";
    message = "${name} needed to be add manually";
  };
  nativeBuildInputs = [
    unzip
    makeWrapper
  ];
  unpackPhase = ''
    unzip $src
  '';
  installPhase = ''
    mkdir -p $out/lib/{vst3,clap}
    cp -r asymmetry-rider.vst3 $out/lib/vst3
    cp -r asymmetry-rider.clap $out/lib/clap
  '';
})
