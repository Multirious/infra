top: {
  configurations.homeManager.peach.use = [ "nix" ];
  configurations.nixos.peach-asus.use = [ "nix" ];

  homeManager.nix.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.patchelf
        top.inputs.nix-alien.packages.${pkgs.stdenv.system}.nix-alien
        pkgs.nix-output-monitor
      ];
      programs.nix-index = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;
      };
    };

  nixos.nix.module =
    { ... }:
    {
      programs.nix-ld.enable = true;
    };
}
