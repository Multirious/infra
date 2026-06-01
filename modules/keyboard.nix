top: {
  configurations.nixos.peach-asus.use = [ "keyboard" ];
  configurations.homeManager.peach.use = [ "keyboard" ];

  homeManager.keyboard.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.zmk-studio
      ];
    };

  nixos.keyboard.module =
    { ... }:
    {
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        # font = "Lat2-Terminus16";
        # keyMap = "us";
        # useXkbConfig = true;
      };
      services.xserver.xkb.layout = "us";
      services.xserver.xkb.options = "";
      services.libinput.enable = true;
    };
}
