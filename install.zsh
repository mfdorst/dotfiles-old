#!/bin/zsh

# Quit if ~/.dotfiles/.installed exists - this file is created by this script,
# so it's existence indicates that this script has already been run.

if [[ -a ~/.dotfiles/.installed ]]; then
    echo "This script has already been run."
    echo "If you would like to run it again, run:"
    echo "rm ~/.dotfiles/.installed"
    echo "and run this script again."
    exit 1
fi

# Create the .installed file, to prevent accidental re-running of this script

touch ~/.dotfiles/.installed

# Create symlinks for the following files

ln -s ~/.dotfiles/.bashrc ~
ln -s ~/.dotfiles/.zshrc ~

