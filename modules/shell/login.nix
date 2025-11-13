top: {
  flake.modules.homeManager.shell =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (config.xdg)
        configHome
        cacheHome
        stateHome
        dataHome
        userDirs
        ;
      inherit (config.home) homeDirectory;
    in
    {
      options = {
        shell = {
          unix.login = lib.mkOption {
            type = lib.types.lines;
          };
          sh.login = lib.mkOption {
            type = lib.types.lines;
          };
          bash.login = lib.mkOption {
            type = lib.types.lines;
          };
          zsh.login = lib.mkOption {
            type = lib.types.lines;
          };
        };
      };
      config = {
        xdg.configFile."shell/unix/login".text =
          # sh
          ''
            export HOME="${homeDirectory}"

            export EDITOR=hx
            export VISUAL=$EDITOR

            export LANG="en_US.UTF-8"
            export LC_LANG="en_US.UTF-8"
            export LC_ALL="en_US.UTF-8"

            export XDG_CONFIG_HOME="${configHome}"
            export XDG_STATE_HOME="${stateHome}"
            export XDG_DATA_HOME="${dataHome}"
            export XDG_CACHE_HOME="${cacheHome}"

            export XDG_DESKTOP_DIR="${userDirs.desktop}"
            export XDG_DOCUMENTS_DIR="${userDirs.documents}"
            export XDG_DOWNLOAD_DIR="${userDirs.download}"
            export XDG_MUSIC_DIR="${userDirs.music}"
            export XDG_PICTURES_DIR="${userDirs.pictures}"
            export XDG_PUBLICSHARE_DIR="${userDirs.publicShare}"
            export XDG_TEMPLATES_DIR="${userDirs.templates}"
            export XDG_VIDEOS_DIR="${userDirs.videos}"

            export STARSHIP_CONFIG="${configHome}/starship.toml"
            export STARSHIP_CACHE="${cacheHome}/starship"

            if has-command less; then
              [ -d "${stateHome}/less" ] || mkdir -p "${stateHome}/less"
              export LESSHISTFILE="${stateHome}/less/history"
              [ -f "${homeDirectory}/.lesshst" ] && rm "${homeDirectory}/.lesshst"
            fi

            if [ -d "${homeDirectory}/.cargo/bin" ]; then
              export PATH="${homeDirectory}/.cargo/bin:$PATH"
            fi

            if has-command wget; then
              [ -d "${configHome}/wget" ] || mkdir -p "${configHome}/wget"
              alias wget="wget --hsts-file ${configHome}/wget/hsts"
            fi

            try-source "${homeDirectory}/.nix-profile/etc/profile.d/hm-session-vars.sh"

            export PATH="${homeDirectory}/.local/bin:$PATH"
          '';
        xdg.configFile."shell/sh/login".text =
          # sh
          ''
            . ${configHome}/shell/unix/login
          '';
        xdg.configFile."shell/bash/login".text =
          # bash
          ''
            . ${configHome}/shell/unix/login
          '';
        xdg.configFile."shell/zsh/login".text =
          # zsh
          ''
            . ${configHome}/shell/unix/login
          '';
      };
    };
}
