top: {
  configurations.homeManager.peach.use = [ "nix" ];
  configurations.nixos.peach-asus.use = [ "nix" ];

  homeManager.nix.module =
    { ... }:
    {
      programs.nix-index.enable = true;
      programs.nix-index.enableBashIntegration = false;
      programs.nix-index.enableZshIntegration = false;
    };

  flake.modules.nixos.nix =
    { ... }:
    {
      programs.nix-ld.enable = true;
    };
}
