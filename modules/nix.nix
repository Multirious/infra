top: {
  configurations.homeManager.peach.use = m: [ m.nix ];
  configurations.nixos.peach-asus.use = m: [ m.nix ];

  flake.modules.homeManager.nix =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.nixd
        pkgs.nixfmt-rfc-style
      ];
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
