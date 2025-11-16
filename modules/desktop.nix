top: {
  configurations.homeManager.peach.use = m: [ m.desktop ];

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages =

        let
          discord = pkgs.discord.overrideAttrs (prev: {
            version = "0.0.93";
            src = pkgs.fetchurl {
              url = "https://stable.dl2.discordapp.net/apps/linux/0.0.93/discord-0.0.93.tar.gz";
              hash = "sha256-/CTgRWMi7RnsIrzWrXHE5D9zFte7GgqimxnvJTj3hFY=";
            };
          });
        in
        [
          pkgs.nautilus
          pkgs.udiskie
          pkgs.obsidian
          pkgs.lan-mouse
          pkgs.megasync

          discord

          pkgs.xclicker
        ];
      services.syncthing.enable = true;
      xdg.mimeApps = {
        defaultApplications = {
          "inode/directory" = [ "nautilus.desktop" ];
        };
        associations.removed = {
          "inode/directory" = "kitty-open.desktop";
        };
      };
    };
}
