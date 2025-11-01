top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.git
  ];

  flake.modules.homeManager.git =
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
        home.file.".config/git/config".text = cfg.config;

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

            [includeIf "gitdir:~/university/"]
            	path = /home/peach/university/.gitconfig-university
          '';
      };
    };
}
