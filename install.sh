#!/bin/sh

if [ "$1" = "-y" ]; then
    DEFAULTS=yes
else
    DEFAULTS=no
fi

symlink()
{
    if [ -e "$HOME/$2" ] || [ -h "$HOME/$2" ]; then
        rm "$HOME/$2"
    fi
    ln -s "$HOME/.dotfiles/$1/$2" ~
    echo "Symlinked $2 -> .dotfiles/$1/$2\n"
}

symlink_prompt()
{
    if [ "$DEFAULTS" = "yes" ]; then
        symlink $1 $2
    else
        if [ -e "$HOME/$2" ] || [ -h "$HOME/$2" ]; then
            printf %s "$2 exists, would you like to overwrite it? [Y | n] "
        else
            printf %s "Would you like to symlink $2? [Y | n] "
        fi

        local link
        read link
        if echo $link | grep -Eqiw 'n|no'; then
            echo "$2 was not symlinked.\n"
        else
            symlink $1 $2
        fi
    fi
}

install_antigen()
{
    mkdir "$HOME/.antigen"
    curl -L git.io/antigen > "$HOME/.antigen/antigen.zsh"
    echo "Antigen was installed."
}

if [ ! -e "$HOME/.antigen" ]; then
    if [ "$DEFAULTS" = "yes" ]; then
        install_antigen
    else
        echo "Would you like to install antigen? [Y | n]"
        read should_install_antigen
        if echo $should_install_antigen | grep -Eqiw 'n|no'; then
            echo "Antigen was not installed."
        else
            install_antigen
        fi
    fi
else
    echo "Antigen is already installed.\n"
fi

if [ ! -e "$HOME/.zsh_theme" ]; then
    if [ "$DEFAULTS" = "no" ]; then
        printf %s "The default Oh My Zsh theme is spaceship-prompt. Would you like to change it? [y | N] "
        read chose_theme
        if echo $chose_theme | grep -Eqiw 'y|yes'; then
            echo "What theme would you like?"
            read theme
            echo "antigen theme $theme" > ~/.zsh_theme
            echo "Your theme was changed to $theme."
        else
            echo "Your theme was set to anthropomorphic/spaceship-prompt. Edit .zsh_theme to change it.\n"
        fi
    fi
fi

for f in `ls -a "$HOME"/.dotfiles/universal | grep -vE "^\.{1,2}$"`; do
    [ -e "$HOME/.dotfiles/universal/$f" ] || continue
    symlink_prompt universal "$f"
done

#### MacOS only ####
install_brew()
{
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebrew was installed."
}

install_brew_prompt()
{
    # If brew is not installed
    if [ $(which brew &> /dev/null) ]; then
        if [ "$DEFAULTS" = "yes" ]; then
            install_brew
        else
            printf %s "Would you like to install homebrew? [Y | n] "
            read should_install_brew
            if echo $should_install_brew | grep -Eqiw 'n|no'; then
                echo "Homebrew was not installed.\n"
            else
                install_brew
            fi
        fi
    else
        echo "Homebrew is already installed."
    fi
}

install_coreutils()
{
    brew install coreutils
    echo "Coreutils installed."
}

install_coreutils_prompt()
{
    # If brew is installed
    if which brew &> /dev/null; then
        # If coreutils is not installed
        if [ $(which gls &> /dev/null) ]; then
            if [ "$DEFAULTS" = "yes" ]; then
                install_coreutils
            else
                echo "Would you like to install coreutils? [Y | n]"
                read should_install_coreutils
                if echo $should_install_coreutils | grep -Eqiw 'n|no'; then
                    echo "Coreutils was not installed."
                else
                    install_coreutils
                fi
            fi
        else
            echo "Coreutils is already installed."
        fi
    else
        echo "Homebrew is not installed."
    fi
}
#### End MacOS only ####

if [ "$OSTYPE" = "linux-gnu" ]; then
    symlink_prompt platform_specific .zshrc.linux
elif [ "$OSTYPE" = "darwin"* ]; then
    echo "MacOS detected. MacOS specific options:"
    symlink_prompt platform_specific .zshrc.macos
    install_brew_prompt
    install_coreutils_prompt
fi

if [ $SHELL != '/bin/zsh' ]; then
    if [ "$DEFAULTS" = "yes" ]; then
        chsh -s /bin/zsh
    else
        echo "Your shell is currently set to $SHELL. Would you like to change it to /bin/zsh? [y | N]"
        read change_shell
        if echo $change_shell | grep -Eqiw 'y|yes'; then
            chsh -s /bin/zsh
            echo "Your shell was changed to /bin/zsh."
        else
            echo "Your shell was not changed."
        fi
    fi
fi

echo "Run 'exec zsh' to begin using your new shell."
