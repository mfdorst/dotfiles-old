####################################
## TO CUSTOMIZE, USE .zshrc.local ##
####################################

source "$HOME/.antigen/antigen.zsh"
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle heroku
antigen bundle vi-mode
antigen bundle command-not-found

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme
if [[ -e "$HOME/.zsh_theme" ]]; then
    source "$HOME/.zsh_theme"
else
    # Load custom forked version of denysdovhan's spaceship-prompt
    antigen theme https://github.com/anthropomorphic/spaceship-prompt spaceship

    # Apply custom theme settings
    SPACESHIP_VI_MODE_INSERT=
    SPACESHIP_VI_MODE_SUFFIX=
    SPACESHIP_VI_MODE_NORMAL="[V] "
    SPACESHIP_USER_COLOR=green
    SPACESHIP_USER_SHOW=always
    SPACESHIP_DIR_TRUNC_PREFIX=".../"
    SPACESHIP_CHAR_SYMBOL_ROOT="#"
    SPACESHIP_CHAR_SYMBOL="$"
    SPACESHIP_CHAR_SUFFIX=" "
fi

antigen apply

# Disable bell
unsetopt BEEP

# Use a UTF-8 locale - fixes an issue with the oh-my-zsh 'bira' theme, where the
# prompt would break on non-zero return values
LANG=en_US.UTF-8

# Make a directory and cd into it
mcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

alias ducks='du -cksh * | sort -hr'

alias h='head -n'

# Load platform specific rc files
if [[ -e "$HOME/.zshrc.macos" ]]; then
    source "$HOME/.zshrc.macos"
fi

if [[ -e "$HOME/.zshrc.ubuntu" ]]; then
    source "$HOME/.zshrc.macos"
fi

# Load local rc
if [[ -e "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
