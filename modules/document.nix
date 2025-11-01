top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.document
  ];

  flake.modules.homeManager.document =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.libreoffice
      ];
      xdg.mimeApps = {
        defaultApplications = {
          "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
        };
      };
    };
}
