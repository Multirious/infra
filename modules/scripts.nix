top: {
  configurations.homeManager.peach.use = [ "scripts" ];

  homeManager.scripts.module =
    { ... }:
    {
      home.file = {
        "scripts/debug-derivative" = {
          executable = true;
          source = ./scripts/debug-derivative;
        };
        "scripts/clipboard-react-emote" = {
          executable = true;
          source = ./scripts/clipboard-react-emote;
        };
        "scripts/video-to-gif" = {
          executable = true;
          source = ./scripts/video-to-gif;
        };
      };
    };
}
