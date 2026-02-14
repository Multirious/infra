top: {
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import top.inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      packages = import ../packages/default.nix { inherit pkgs; };
    };
}
