top: {
  configurations.homeManager.peach.use = m: [ m.nix ];
  configurations.nixos.peach-asus.use = m: [ m.nix ];

  flake.modules.homeManager.nix =
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
