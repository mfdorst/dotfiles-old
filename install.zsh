#!/bin/zsh

if [[ "$1" = "-y" ]]; then
    DEFAULTS=yes
else
    DEFAULTS=no
fi

symlink()
{
    if [[ -a "$HOME/$1" || -h "$HOME/$1" ]]; then
        rm "$HOME/$1"
    fi
    ln -s "$HOME/.dotfiles/files/$1" ~
}

symlink_prompt()
{
    if [[ "$DEFAULTS" = "yes" ]]; then
        symlink $1
    else
        if [[ -e "$HOME/$1" || -h "$HOME/$1" ]]; then
            echo "$1 exists, would you like to overwrite it? [Y | n]"
        else
            echo "Would you like to symlink $1? [Y | n]"
        fi

        local link
        read link
        if echo $link | grep -Eqiw 'y|yes'; then
            symlink $1
        fi
    fi
}

install_antigen()
{
    mkdir "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
}

if [[ ! -e "$HOME/.antigen" ]]; then
    if [[ "$DEFAULTS" = "yes" ]]; then
        install_antigen
    else
        echo "Would you like to install antigen? [Y | n]"
        read should_install_antigen
        if [[ ! $(echo $should_install_antigen | grep -Eqiw 'n|no') ]]; then
            install_antigen
        fi
    fi
fi

for f in ${HOME}/.dotfiles/files/*(N) ${HOME}/.dotfiles/files/.*(N); do
    symlink_prompt $(basename $f)
done

if [[ $SHELL != '/bin/zsh' ]]; then
    if [[ "$DEFAULTS" = "yes" ]]; then
        chsh -s /bin/zsh
    else
        echo "Your shell is currently set to $SHELL. Would you like to change it to /bin/zsh? [y | N]"
        read change_shell
        if echo $change_shell | grep -Eqiw 'y|yes'; then
            chsh -s /bin/zsh
        fi
    fi
fi

if [[ ! -e "$HOME/.zsh_theme" ]]; then
    if [[ "$DEFAULTS" = "no" ]]; then
        echo "Would you like to install a theme? [y | N]"
        read chose_theme
        if echo $chose_theme | grep -Eqiw 'y|yes'; then
            echo "What theme would you like?"
            read theme
            echo "antigen theme $theme" > ~/.zsh_theme
        fi
    fi
fi
