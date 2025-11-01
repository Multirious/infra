top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.fonts
  ];

  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts = {
        packages = with pkgs; [
          nerd-fonts.roboto-mono
          noto-fonts
          newcomputermodern
        ];

        fontconfig = {
          defaultFonts = {
            serif = [
              "NotoSans"
              "newcomputermodern"
            ];
            sansSerif = [ "NotoSerif" ];
            monospace = [ "RobotoMono" ];
          };
        };
      };
    };
}
