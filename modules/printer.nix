top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.printer
  ];

  flake.modules.nixos.printer =
    { pkgs, ... }:
    {
      hardware.sane.extraBackends = with pkgs; [ epsonscan2 ];
      services.printing = {
        enable = true;
        drivers = with pkgs; [
          epson-escpr
          epson-escpr2
        ];
      };
      services.avahi = {
        enable = true;
        nssmdns4 = true;
      };
    };
}
