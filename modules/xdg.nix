top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.xdg
  ];

  flake.modules.homeManager.xdg =
    { ... }:
    {
      xdg.enable = true;
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;
    };
}
