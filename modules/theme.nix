top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.theme
  ];

  flake.modules.homeManager.theme =
    { pkgs, ... }:
    {
      gtk.enable = true;
      home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.posy-cursors;
        name = "Posy_Cursor";
        size = 16;
      };
      gtk.iconTheme.package = pkgs.kdePackages.breeze-icons;
      gtk.iconTheme.name = "breeze";
      gtk.theme.package = pkgs.kdePackages.breeze-gtk;
      gtk.theme.name = "breeze-gtk";
    };
}
