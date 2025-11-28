top: {
  nixos.laptop.use = [ "brightness" ];

  nixos.brightness.module =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ brightnessctl ];
    };
}
