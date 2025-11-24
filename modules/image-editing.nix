top: {
  configurations.homeManager.peach.use = [ "imageEditing" ];

  flake.modules.homeManager.imageEditing =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.gimp
        pkgs.inkscape
      ];
      xdg.mimeApps.defaultApplications = {
        "image/svg+xml" = "org.inkscape.Inkscape.desktop";
      };
    };
}
