top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.automounter
  ];

  flake.modules.nixos.automounter =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ udiskie ];
      services.udisks2.enable = true;
    };
}
