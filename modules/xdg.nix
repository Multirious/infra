top: {
  configurations.homeManager.peach.use = [ "xdg" ];

  flake.modules.homeManager.xdg =
    { config, ... }:
    {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;

        cacheHome = "${config.home.homeDirectory}/.local/cache";
        configHome = "${config.home.homeDirectory}/.local/config";
        dataHome = "${config.home.homeDirectory}/.local/share";
        stateHome = "${config.home.homeDirectory}/.local/state";

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
