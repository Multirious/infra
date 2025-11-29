top: {
  nixos.global.module =
    { lib, ... }:
    {
      system.stateVersion = "24.11"; # Do not change this
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
    };
}
