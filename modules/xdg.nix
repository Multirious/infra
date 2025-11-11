top: {
  configurations.homeManager.peach.use = m: [ m.xdg ];

  flake.modules.homeManager.xdg =
    { ... }:
    {
      xdg.enable = true;
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;
    };
}
