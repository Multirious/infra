top: {
  configurations.homeManager.peach.use = [ "scripts" ];

  flake.modules.homeManager.scripts =
    { ... }:
    {
      home.file."scripts/debug-derivative" = {
        executable = true;
        source = ./scripts/debug-derivative;
      };
    };
}
