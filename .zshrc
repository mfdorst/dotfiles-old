source .antigen.zsh

antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle heroku

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Load liquidprompt
#antigen bundle nojhan/liquidprompt

# Load the theme
antigen theme robbyrussell

antigen apply

# Make a directory and cd into it
mcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

# Disable bell
unsetopt BEEP
