{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
        l = "ls -lh";
        la = "ls -lha";
        v = "nvim";
        vi = "nvim";
        ".." = "cd ..";
      };
    dotDir = "${config.xdg.configHome}/zsh";
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
}
