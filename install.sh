#!/bin/sh

if [ "$1" = "-y" ]; then
    DEFAULTS=yes
else
    DEFAULTS=no
fi

defaults() {
    test "$DEFAULTS" = "yes"
}

user_says_yes() {
    local response
    read response
    echo $response | grep -Eqiw 'y|yes'
}

user_says_no() {
    local response
    read response
    echo $response | grep -Eqiw 'n|no'
}

symlink()
{
    if [ -e "$HOME/$2" ] || [ -h "$HOME/$2" ]; then
        rm "$HOME/$2"
    fi
    ln -s "$HOME/.dotfiles/$1/$2" ~
    echo "Symlinked $2 -> .dotfiles/$1/$2" && echo
}

symlink_prompt()
{
    if defaults; then
        symlink $1 $2
    else
        if [ -e "$HOME/$2" ] || [ -h "$HOME/$2" ]; then
            printf %s "$2 exists, would you like to overwrite it? [Y | n] "
        else
            printf %s "Would you like to symlink $2? [Y | n] "
        fi

        if user_says_no; then
            echo "$2 was not symlinked." && echo
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
    if defaults; then
        install_antigen
    else
        echo "Would you like to install antigen? [Y | n]"

        if user_says_no; then
            echo "Antigen was not installed."
        else
            install_antigen
        fi
    fi
else
    echo "Antigen is already installed." && echo
fi

if [ ! -e "$HOME/.zsh_theme" ]; then
    if defaults; then
        echo "The default theme is spaceship-prompt. Edit .zsh_theme to change it" && echo
    else
        printf %s "The default theme is spaceship-prompt. Would you like to change it? [y | N] "
        
        if user_says_yes; then
            echo "What theme would you like?"
            read theme
            echo "antigen theme $theme" > ~/.zsh_theme
            echo "Your theme was changed to $theme."
        else
            echo ""
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
        if defaults; then
            install_brew
        else
            printf %s "Would you like to install homebrew? [Y | n] "
            
            if user_says_no; then
                echo "Homebrew was not installed." && echo
            else
                install_brew
            fi
        fi
    else
        echo "Homebrew is already installed."
    fi
}

brew_bundle()
{
    echo "Running: brew bundle --global"
    brew bundle --global
}

brew_bundle_prompt()
{
    # If brew is not installed
    if [ ! $(which brew &> /dev/null) ]; then
        if defaults; then
            brew_bundle
        else
            printf %s "Would you like to install the packages listed in .Brewfile? [Y | n] "
            
            if user_says_no; then
                echo "Packages not installed. Run 'brew bundle --global' to install them."
            else
                brew_bundle
            fi
        fi
    else
        echo "Homebrew is not installed. Skipping 'brew bundle --global'."
    fi
}

#### End MacOS only ####

if [ $(uname) = "Linux" ]; then
    echo "Linux detected. Linux specific options:"
    symlink_prompt platform_specific .zshrc.linux
elif [ $(uname) = "Darwin" ]; then
    echo "MacOS detected. MacOS specific options:"
    symlink_prompt platform_specific .zshrc.macos
    symlink_prompt platform_specific .Brewfile
    install_brew_prompt
    brew_bundle_prompt
fi

if [ $SHELL != '/bin/zsh' ]; then
    if defaults; then
        chsh -s /bin/zsh
    else
        printf %s "Your shell is currently set to $SHELL. Would you like to change it to /bin/zsh? [y | N] "
        
        if user_says_yes; then
            chsh -s /bin/zsh
            echo "Your shell was changed to /bin/zsh."
        else
            echo "Your shell was not changed."
        fi
    fi
fi

echo
echo "Run 'exec zsh' to begin using your new shell."
