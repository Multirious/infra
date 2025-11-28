top: {
  configurations.homeManager.peach.use = [ "scripts" ];

  homeManager.scripts.module =
    { ... }:
    {
      home.file."scripts/debug-derivative" = {
        executable = true;
        source = ./scripts/debug-derivative;
      };
    };
}
