{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    qview
    streamlink
    btop
    vlc
    discordo
    chatterino7
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "alice";
      user.email = "aliceecity@proton.me";
      init.defaultBranch = "main";
    };
  };

  programs.firefox.enable = true;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind C-b
      set -g prefix º
      bind º send-prefix

      unbind l
      unbind Up
      unbind Down
      unbind Right
      unbind Left

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key & kill-window
      bind-key x kill-pane

      bind-key S new-window bash -c "~/scripts/nvim-go-to.sh"
      bind-key A run-shell "tmux neww ~/scripts/cht.sh"

      set -a terminal-features "screen-256color:RGB"

      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on

      set -g status-position top
      set -g status-style "bg=default"
      set -g window-status-current-style "fg=blue bold"
      set -g status-right ""
      set -g status-left ""
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
        l = "ls -lh";
        la = "ls -lha";
        v = "nvim";
        vi = "nvim";
        ".." = "cd ..";
      };
    dotDir = ".config/zsh";
    initContent = ''
      # The following lines were added by compinstall

      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle :compinstall filename '/home/sancho/.zshrc'

      autoload -Uz compinit
      compinit
      # End of lines added by compinstall

      autoload -U colors && colors

      PROMPT="%B%F{#5c47c9}[%n@%m:%~]%b%f "

      bindkey -e
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word

      alias frf="nohup firefox >& /dev/null &"
      alias ":q"="exit"
      ttv(){
        if [ -z $2 ]; then
          qual="best"
        else
          qual="$2"
        fi

        nohup streamlink twitch.tv/"$1" "$qual" >& /dev/null &
      }

      export EDITOR=nvim
    '';
  };

  home.stateVersion = "25.11";
}
