top:
let
  fontPkgs =
    pkgs: with pkgs; [
      nerd-fonts.roboto-mono
      noto-fonts
      newcomputermodern
      wqy_zenhei
    ];
  defaultFonts = {
    serif = [
      "NotoSans"
      "newcomputermodern"
    ];
    sansSerif = [ "NotoSerif" ];
    monospace = [ "RobotoMono" ];
  };
in
{
  configurations.nixos.peach-asus.use = [ "fonts" ];
  configurations.homeManager.peach.use = [ "fonts" ];

  homeManager.fonts.module =
    { pkgs, lib, ... }:
    {
      options = {
        fonts.packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          description = "List of font packages. To only be used in my homemanager config";
        };
      };
      config = {
        fonts.fontconfig.enable = true;
        fonts.fontconfig.defaultFonts = defaultFonts;
        fonts.packages = fontPkgs pkgs;
      };
    };

  nixos.fonts.module =
    { pkgs, ... }:
    {
      fonts = {
        packages = fontPkgs pkgs;
        fontconfig.defaultFonts = defaultFonts;
      };
      console = {
        earlySetup = true;
        font = "${pkgs.terminus_font}/share/consolefonts/ter-v24b.psf.gz";
        packages = [ pkgs.terminus_font ];
      };
    };
}
