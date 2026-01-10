top: {
  configurations.homeManager.peach.use = [ "desktop" ];

  homeManager.desktop.module =
    { pkgs, ... }:
    {
      home.packages =

        let
          discord = pkgs.discord.overrideAttrs (prev: {
            version = "0.0.119";
            src = pkgs.fetchurl {
              url = "https://stable.dl2.discordapp.net/apps/linux/0.0.119/discord-0.0.119.tar.gz";
              hash = "sha256-/NfgHBXsUWYoDEVGz13GBU1ISpSdB5OmrjhSN25SBMg=";
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
