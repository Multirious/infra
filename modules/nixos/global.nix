top: {
  nixos.global.module =
    { ... }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      nixpkgs.config.allowUnfree = true;
    };
}
