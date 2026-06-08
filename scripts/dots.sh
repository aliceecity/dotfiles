#!/bin/sh

dots_dir=$(realpath "$0" | awk -F'/' -v OFS='/' '{NF-=2}1')

user=$(whoami)

if [[ "$1" == "-d" ]]; then
  dry="true"
fi

function sl() {
  if [[ ! -n $2 ]]; then
    dest="$HOME/.config/$1"
  else
    dest="$HOME/$2"
  fi

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "$dest already exists and is not a symlink." 
    return 1
  fi

  if [[ ! -e "$dots_dir/configs/$1" ]]; then
    echo "$dots_dir/configs/$1 does not exist."
    return 2
  fi

  if [[ -n "$dry" ]]; then
    [[ -L "$dest" ]] && echo -e "rm -r $dest\n$dest -> $(realpath $dest)"

    echo "ln -sv \"$dots_dir/configs/$1\" \"$dest\""
  else
    [[ -L "$dest" ]] && rm -r "$dest"

    ln -sv "$dots_dir/configs/$1" "$dest"
  fi
}

case "$user" in
  reg)
    sl zsh/zshrc .config/zsh/.zshrc
    sl zsh/zshenv .zshenv
    sl tmux/tmux.conf
    sl nvim
    sl git
    sl hypr/keybinds.lua
    sl hypr/abyss.lua .config/hypr/hyprland.lua
    hyprctl reload &> /dev/null
    sl alacritty
    sl waybar
    sl ssh/config .ssh/config
  ;;
  sancho)
    sl zsh/zshrc .config/zsh/.zshrc
    sl zsh/zshenv .zshenv
    sl tmux/tmux.conf
    sl nvim
    sl git
    sl hypr/keybinds.lua
    sl hypr/lethe.lua .config/hypr/hyprland.lua
    hyprctl reload &> /dev/null
    sl alacritty
    sl waybar
    sl ssh/config .ssh/config
  ;;
  *)
    echo "Unrecognized user."
  ;;
esac
