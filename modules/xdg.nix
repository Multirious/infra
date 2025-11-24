top: {
  configurations.homeManager.peach.use = [ "xdg" ];

  flake.modules.homeManager.xdg =
    { config, ... }:
    let
      homeDir = config.home.homeDirectory;
    in
    {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;

        cacheHome = "${homeDir}/.local/cache";
        configHome = "${homeDir}/.local/config";
        dataHome = "${homeDir}/.local/share";
        stateHome = "${homeDir}/.local/state";

        userDirs = {
          enable = true;
          desktop = "desktop";
          documents = "documents";
          download = "download";
          music = "music";
          pictures = "pictures";
          publicShare = "public";
          templates = "templates";
          videos = "videos";
        };
      };
    };
}
