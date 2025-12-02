{
  pkgs,
  unzip,
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "MiniMeters";
  src = pkgs.requireFile {
    name = "minimeters-linux.zip";
    sha256 = "0300n9l2sb3nsg7rbs5hzjxax41pqb7k7s9gnzpdq4x7402vll19";
    message = "This paid tool needed to be downloaded manually through itch.io";
  };
  buildInputs = [
    unzip
  ];
  unpack = ''
    unzip minimeters-linux.zip
  '';
  build = ''
    ls
    exit 1
  '';
}
