#!/bin/zsh

file_exists()
{
    echo "$1 exists. Please remove it and rerun this script if you would like to symlink it."
}

prompt_symlink()
{
    echo "Would you like to symlink $1? [y/N]: "
}

if [[ -a ~/.bashrc ]]; then
    file_exists '~/.bashrc'
else
    prompt_symlink '~/.bashrc'
    read link_bashrc

    if echo $link_bashrc | grep -Eqiw 'y|yes'; then
        ln -s ~/.dotfiles/.bashrc ~
    fi
fi

if [[ -a ~/.zshrc ]]; then
    file_exists '~/.zshrc'
else
    prompt_symlink '~/.zshrc'
    read link_zshrc
    if echo $link_zshrc | grep -Eqiw 'y|yes'; then
        ln -s ~/.dotfiles/.zshrc ~
    fi
fi

