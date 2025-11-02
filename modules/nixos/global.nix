top: {
  flake.modules.nixos.global =
    { lib, ... }:
    {
      system.stateVersion = "24.11"; # Do not change this
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "epson-201401w"
          "logmein-hamachi"
        ];
    };
}
