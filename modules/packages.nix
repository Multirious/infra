top: {
  perSystem =
    { pkgs, ... }:
    {
      packages = import ../packages/default.nix { inherit pkgs; };
    };
}
