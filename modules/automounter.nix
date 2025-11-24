top: {
  configurations.nixos.peach-asus.use = [ "automounter" ];

  flake.modules.nixos.automounter =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ udiskie ];
      services.udisks2.enable = true;
    };
}
