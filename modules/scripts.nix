top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.scripts
  ];

  flake.modules.homeManager.scripts =
    { ... }:
    {
      home.file."scripts/debug-derivative" = {
        executable = true;
        source = ./scripts/debug-derivative;
      };
    };
}
