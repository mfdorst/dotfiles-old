#!/bin/zsh

symlink_prompt()
{
    if [[ -a "$HOME/$1" || -h "$HOME/$1" ]]; then
        echo "$1 exists, would you like to overwrite it? [y/n]"
    else
        echo "Would you like to symlink $1? [y/n]"
    fi

    local link
    read link
    if echo $link | grep -Eqiw 'y|yes'; then
        if [[ -a "$HOME/$1" || -h "$HOME/$1" ]]; then
            rm "$HOME/$1"
        fi
        ln -s "$HOME/.dotfiles/files/$1" ~
    fi
}

if [[ ! -a "$HOME/.antigen.zsh" ]]; then
    echo "Would you like to install antigen? [y/n]"
    read install_antigen
    if echo $install_antigen | grep -Eqiw 'y|yes'; then
        curl -L git.io/antigen > .antigen.zsh
    fi
fi

for f in ${HOME}/.dotfiles/files/*(N) ${HOME}/.dotfiles/files/.*(N); do
    symlink_prompt $(basename $f)
done

if [[ $SHELL != '/bin/zsh' ]]; then
    echo "Your shell is currently set to $SHELL. Would you like to change it to /bin/zsh?"
    read change_shell
    if echo $change_shell | grep -Eqiw 'y|yes'; then
        chsh -s /bin/zsh
    fi
fi

if [[ ! -a "$HOME/.zsh_theme" ]]; then
    echo "Would you like to install a theme? [y/n]"
    read chose_theme
    if echo $chose_theme | grep -Eqiw 'y|yes'; then
        echo "What theme would you like?"
        read theme
        echo "antigen theme $theme" > ~/.zsh_theme
    fi
fi

