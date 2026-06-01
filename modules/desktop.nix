top: {
  configurations.homeManager.peach.use = [ "desktop" ];

  homeManager.desktop.module =
    { pkgs, ... }:
    {
      home.packages =

        [
          pkgs.nautilus
          pkgs.udiskie
          pkgs.obsidian
          pkgs.lan-mouse
          pkgs.megasync

          pkgs.discord

          pkgs.xclicker
        ];
      services.syncthing.enable = true;
      xdg.mimeApps = {
        defaultApplications = {
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        };
      };
    };
}
