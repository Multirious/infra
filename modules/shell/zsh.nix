top: {
  flake.modules.homeManager.shell =
    { ... }:
    {
      home.file.".zshenv".text =
        # zsh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          . ~/.config/shell/zsh/env
        '';

      home.file.".zshrc".text =
        # zsh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          source ~/.config/shell/zsh/interactive
        '';

      home.file.".zprofile".text =
        # zsh
        ''
          # This script is part of an attempt to
          # standardize shell configurations

          . ~/.config/shell/zsh/login
        '';

      home.file.".config/shell/zsh/completion.zsh".text =
        # zsh
        ''
          autoload -U compinit
          compinit -d "$XDG_STATE_HOME/zsh/compdump"

          _comp_options+=(globdots) # With hidden files

          zstyle ':completion:*' completer _extensions _complete _approximate
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
          zstyle ':completion:*' menu select
        '';

      home.file.".config/shell/zsh/plugins.zsh".text =
        # zsh
        ''
          source <(fzf --zsh)

          source ${top.inputs.zsh-helix-mode}/zsh-helix-mode.plugin.zsh
          bindkey -M hxins "jk" zhm_normal

          source ${top.inputs.zsh-autosuggestions}/zsh-autosuggestions.plugin.zsh
          ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
            zhm_history_prev
            zhm_history_next
            zhm_prompt_accept
            zhm_accept
            zhm_accept_or_insert_newline
          )
          ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(
            zhm_move_right
            zhm_clear_selection_move_right
          )
          ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(
            zhm_move_next_word_start
            zhm_move_next_word_end
          )

          source ${top.inputs.zsh-syntax-highlighting}/zsh-syntax-highlighting.zsh

          zhm-add-update-region-highlight-hook
        '';
    };
}
