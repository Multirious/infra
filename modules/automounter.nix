top: {
  configurations.nixos.peach-asus.use = m: [ m.automounter ];

  flake.modules.nixos.automounter =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ udiskie ];
      services.udisks2.enable = true;
    };
}
