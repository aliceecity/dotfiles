#!/bin/sh

dots_dir=$(realpath "$0" | awk -F'/' -v OFS='/' '{NF-=2}1')

host=$(hostname)

[[ "$1" == "-d" ]] && dry="true"

function sl() {
  [[ ! -n $2 ]] && dest="$HOME/.config/$1"
                || dest="$HOME/$2"

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

case "$host" in
  abyss)
    sl zsh/zshrc .config/zsh/.zshrc
    sl zsh/abyssrc .config/zsh/prompt
    sl zsh/zshenv .zshenv
    sl tmux/tmux.conf
    sl tmux/abyss.conf .config/tmux/colors.conf
    sl nvim
    sl git
    sl hypr/keybinds.lua
    sl hypr/abyss.lua .config/hypr/hyprland.lua
    hyprctl reload &> /dev/null
    sl alacritty
    sl waybar/config.jsonc
    sl waybar/abyss.css .config/waybar/style.css
    sl ssh/config .ssh/config
    sl waywall
  ;;
  lethe)
    sl zsh/zshrc .config/zsh/.zshrc
    sl zsh/letherc .config/zsh/prompt
    sl zsh/zshenv .zshenv
    sl tmux/tmux.conf
    sl tmux/lethe.conf .config/tmux/colors.conf
    sl nvim
    sl git
    sl hypr/keybinds.lua
    sl hypr/lethe.lua .config/hypr/hyprland.lua
    hyprctl reload &> /dev/null
    sl alacritty
    sl waybar/config.jsonc
    sl waybar/lethe.css .config/waybar/style.css
    sl ssh/config .ssh/config
  ;;
  *)
    echo "Unrecognized host."
  ;;
esac
