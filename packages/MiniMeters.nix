{
  pkgs,
  apiKeyPath,
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "MiniMeters";
  src = (pkgs.callPackage ../lib { }).fetchFromItch {
    creator = "directmusic";
    game = "minimeters";
    uploadName = "minimeters-linux.zip";
    inherit apiKeyPath;
  };
  build = ''
    ls
    exit 1
  '';
}
