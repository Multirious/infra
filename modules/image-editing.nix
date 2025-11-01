top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.imageEditing
  ];

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
