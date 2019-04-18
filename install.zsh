#!/bin/zsh

symlink_prompt()
{
    if [[ -e "$HOME/$1" || -h "$HOME/$1" ]]; then
        echo "$1 exists, would you like to overwrite it? [y | N]"
    else
        echo "Would you like to symlink $1? [y | N]"
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

if [[ ! -e "$HOME/.antigen" ]]; then
    echo "Would you like to install antigen? [y | N]"
    read install_antigen
    if echo $install_antigen | grep -Eqiw 'y|yes'; then
        mkdir "$HOME/.antigen"
        curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
    fi
fi

for f in ${HOME}/.dotfiles/files/*(N) ${HOME}/.dotfiles/files/.*(N); do
    symlink_prompt $(basename $f)
done

if [[ $SHELL != '/bin/zsh' ]]; then
    echo "Your shell is currently set to $SHELL. Would you like to change it to /bin/zsh? [y | N]"
    read change_shell
    if echo $change_shell | grep -Eqiw 'y|yes'; then
        chsh -s /bin/zsh
    fi
fi

if [[ ! -e "$HOME/.zsh_theme" ]]; then
    echo "Would you like to install a theme? [y | N]"
    read chose_theme
    if echo $chose_theme | grep -Eqiw 'y|yes'; then
        echo "What theme would you like?"
        read theme
        echo "antigen theme $theme" > ~/.zsh_theme
    fi
fi

