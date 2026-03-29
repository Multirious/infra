top: {
  configurations.homeManager.peach.use = [ "xdg" ];

  homeManager.xdg.module =
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
          desktop = "${homeDir}/desktop";
          documents = "${homeDir}/documents";
          download = "${homeDir}/download";
          music = "${homeDir}/music";
          pictures = "${homeDir}/pictures";
          publicShare = "${homeDir}/public";
          templates = "${homeDir}/templates";
          videos = "${homeDir}/videos";
        };
      };
    };
}
