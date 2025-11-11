let
  package =
    { pkgs, lib, ... }:
    pkgs.symlinkJoin {
      name = "openutauWithLibXi";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.openutau ];
      postBuild = ''
        wrapProgram $out/bin/OpenUtau \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pkgs.xorg.libXi ]}
      '';
    };
in
top: {
  perSystem =
    { pkgs, ... }:
    {
      packages.openutau = pkgs.callPackage package { };
    };
}
