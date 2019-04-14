#!/bin/zsh

symlink_prompt()
{
    if [[ -a "$HOME/$1" ]]; then
        echo "~/$1 exists. Please remove it and rerun this script if you would like to symlink it."
    else
        echo "Would you like to symlink $1? [y/n]"
        local link
        read link
        if echo $link | grep -Eqiw 'y|yes'; then
            ln -s "$HOME/.dotfiles/$1" ~
        fi
    fi
}

symlink_prompt '.bashrc'

symlink_prompt '.zshrc'

symlink_prompt '.vimrc'

