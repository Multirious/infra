top: {
  flake.modules.nixos.laptop.imports = [
    top.config.flake.modules.nixos.brightness
  ];

  flake.modules.nixos.brightness =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ brightnessctl ];
    };
}
