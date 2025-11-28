top: {
  configurations.homeManager.peach.use = [ "git" ];

  homeManager.git.module =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.me.git;
    in
    {
      options = {
        me.git.config = lib.mkOption { type = lib.types.lines; };
      };
      config = {
        home.packages = [
          pkgs.git
        ];
        xdg.configFile."git/config".text = cfg.config;

        me.git.config =
          # git-config
          ''
            [init]
                defaultBranch = main
            [core]
                editor = hx
                autocrlf = false
            [user]
                name = Multirious
                email = multirious@outlook.com
                signingkey = /home/peach/.ssh/id_ed25519.pub
            [pull]
                rebase = true
            [gpg]
                format = ssh
            [diff]
                algorithm = patience
            [commit]
                gpgsign = true
          '';
      };
    };
}
