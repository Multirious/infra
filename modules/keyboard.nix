top: {
  configurations.nixos.peach-asus.module.imports = [
    top.config.flake.modules.nixos.keyboard
  ];

  flake.modules.nixos.keyboard =
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
