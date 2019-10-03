#=----------------------------------------------------------------------------=#
# Author: Michael Dorst                                                        #
#=----------------------------------------------------------------------------=#

#=----------------------------------------------------------------------------=#
## TO CUSTOMIZE, USE .zshrc.local                                              #
#=----------------------------------------------------------------------------=#

source "HOME/.antigen/antigen.zsh"
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle heroku
antigen bundle vi-mode
antigen bundle command-not-found
antigen bundle history-substring-search

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Enable history search on up/down arrows
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Load the theme
if [[ -e "HOME/.zsh_theme" ]]; then
    source "HOME/.zsh_theme"
else
    # Load custom forked version of denysdovhan's spaceship-prompt
    antigen theme https://github.com/mfdorst/spaceship-prompt spaceship

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
    SPACESHIP_CONDA_SHOW=false
fi

antigen apply

# Disable bell
unsetopt BEEP

# Use a UTF-8 locale - fixes an issue with the oh-my-zsh 'bira' theme, where the
# prompt would break on non-zero return values
export LANG=en_US.UTF-8

export EDITOR=vim
export VISUAL=vim

# Make a directory and cd into it
mcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

# Aliases
alias ducks='du -cksh * | sort -hr'
alias h='head -n'

# Load platform specific rc files
if [[ -e "HOME/.zshrc.macos" ]]; then
    source "HOME/.zshrc.macos"
fi

if [[ -e "HOME/.zshrc.linux" ]]; then
    source "HOME/.zshrc.linux"
fi

# Load local rc
if [[ -e "HOME/.zshrc.local" ]]; then
    source "HOME/.zshrc.local"
fi

# Anaconda
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Rust/Cargo
export PATH="HOME/.cargo/bin:$PATH"

# pyenv
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
fi

# rbenv
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init -)"
fi
