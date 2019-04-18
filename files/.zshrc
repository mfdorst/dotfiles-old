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
if [[ -a "$HOME/.zsh_theme" ]]; then
    source "$HOME/.zsh_theme"
else
    antigen theme robbyrussell
fi

antigen apply

# Make a directory and cd into it
mcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

# Disable bell
unsetopt BEEP
