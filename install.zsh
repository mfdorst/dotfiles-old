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

if [[ ! -a "$HOME/.antigen.zsh" ]]; then
    echo "Would you like to install antigen? [y/n]"
    read install_antigen
    if echo $install_antigen | grep -Eqiw 'y|yes'; then
        curl -L git.io/antigen > .antigen.zsh
    fi
fi

symlink_prompt '.bashrc'

symlink_prompt '.zshrc'

symlink_prompt '.vimrc'

if [[ $SHELL != '/bin/zsh' ]]; then
    echo "Your shell is currently set to $SHELL. Would you like to change it to /bin/zsh?"
    read change_shell
    if echo $change_shell | grep -Eqiw 'y|yes'; then
        chsh -s /bin/zsh
    fi
fi

