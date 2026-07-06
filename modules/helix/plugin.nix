top@{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      packages = rec {
        steel = inputs.steel.packages.${system}.steel;
        scooter-hx = pkgs.rustPlatform.buildRustPackage {
          name = "scooter.hx";
          src = inputs.scooter-hx;
          nativeBuildInputs = [
            pkgs.rust-bin.stable.latest.minimal
            steel
          ];
          cargoHash = "sha256-LrTjw3iZg33C/u+tBIMeMtq8Y6SCX7+77gc7dLht+go=";
          buildPhase = ''
            export STEEL_HOME=steel
            mkdir steel
            cargo steel-lib
          '';
          doCheck = false;
          installPhase = ''
            mkdir -p $out/share
            cp -r steel $out/share
          '';
        };
      };
    };

  homeManager.helix.module =
    { pkgs, ... }:
    let
      myPkgs = top.config.flake.packages.${pkgs.stdenv.system};
    in
    {
      xdg.dataFile."steel/native/libscooter_hx.so".source =
        "${myPkgs.scooter-hx}/share/steel/native/libscooter_hx.so";
      xdg.configFile."helix/helix.scm".text =
        # scheme
        ''

        '';
      xdg.configFile."helix/init.scm".text =
        # scheme
        ''
          (require "${inputs.scooter-hx}/scooter.scm")
        '';
    };
}
