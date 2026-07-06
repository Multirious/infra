top: {
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import top.inputs.nixpkgs {
        inherit system;
        overlays = [ (import top.inputs.rust-overlay) ];
        config = {
          allowUnfree = true;
        };
      };
      packages = import ../packages/default.nix { inherit pkgs; };
    };
}
