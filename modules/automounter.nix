top: {
  configurations.nixos.peach-asus.use = [ "automounter" ];

  nixos.automounter.module =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ udiskie ];
      services.udisks2.enable = true;
    };
}
