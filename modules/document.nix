top: {
  configurations.homeManager.peach.use = [ "document" ];

  homeManager.document.module =
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
