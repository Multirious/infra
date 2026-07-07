top: {
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import top.inputs.nixpkgs {
        inherit system;
        overlays = [
          (import top.inputs.rust-overlay)

          # For the bottles module
          #
          # Skipping tests while upstream sorts it out, revert once
          # Hydra consistently builds openldap green.
          (final: prev: {
            openldap = prev.openldap.overrideAttrs (_: {
              doCheck = false;
            });
          })
        ];
        config = {
          allowUnfree = true;
        };
      };
      packages = import ../packages/default.nix { inherit pkgs; };
    };
}
