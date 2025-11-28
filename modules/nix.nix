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

  nixos.nix.module =
    { ... }:
    {
      programs.nix-ld.enable = true;
    };
}
