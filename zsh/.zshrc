# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sancho/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U colors && colors

PROMPT="%B%F{#5c47c9}[%n@%m:%~]%b%f "
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
