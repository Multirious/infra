top: {
  nixos.laptop.module.imports = [
    top.config.nixos.brightness.module
  ];

  nixos.brightness.module =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ brightnessctl ];
    };
}
