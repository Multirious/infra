top: {
  configurations.homeManager.peach.module.imports = [
    top.config.flake.modules.homeManager.university
  ];
  flake.modules.homeManager.git =
    { pkgs, lib, ... }:
    {
      me.git.config =
        let
          universityConfig =
            pkgs.writeText "university-git-config"
              # git-config
              ''
                [user]
                	name = peach-on-the-way
                	email = peachinhome@gmail.com
                	signingkey = /home/peach/university/.ssh/id_ed25519.pub

                [core]
                	sshCommand = ssh -i ~/university/.ssh/id_ed25519
              '';
        in
        lib.mkOrder 1010
          # git-config
          ''
            [includeIf "gitdir:~/university/"]
              path = ${universityConfig}
          '';
    };
}
