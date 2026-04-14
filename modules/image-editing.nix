top: {
  configurations.homeManager.peach.use = [ "imageEditing" ];

  homeManager.imageEditing.module =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.gimp
        pkgs.inkscape
        pkgs.kdePackages.kolourpaint
      ];
      xdg.mimeApps.defaultApplications = {
        "image/svg+xml" = "org.inkscape.Inkscape.desktop";
      };
    };
}
