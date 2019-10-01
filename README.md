
# What is this?
My dotfiles tend to get complicated, and I needed a method for version management.
Using `git` to track changes in your home directory is possible, but impractical.
A better solution is to store all of your dotfiles in a dedicated folder which is
under `git` version control, and have symlinks to these files in your home folder.

Of course, this is tedious to manage, so I have an installer script which will
automatically symlink the desired files. This has the added advantage that I can
have specific files which will only be symlinked on specific systems (ie. macOS
vs Linux).

# Instructions

Clone this repository into `~/.dotfiles`:

```
$ git clone https://github.com/mfdorst/dotfiles ~/.dotfiles
```

and run

```
$ ~/.dotfiles/install
```

or

```
$ ~/.dotfiles/install -y # accept default options
```

Installing this will create symlinks in your home directory which will point to the dotfiles
in this repo.
If these files already exist, you will be prompted to replace them (unless run with `-y`).
If you elect to replace them (or run with `-y`), they will be renamed with `.backup` at
the end of their name before the new version is symlinked.

# Custom settings

Some machines need custom settings in their dotfiles. The best way to do this is to create a
secondary dotfile with the custom settings, and source it from the main dotfile.
For instance, local Zsh settings should go in `.zshrc.local`, which is sourced from `.zshrc`.

# How can I use this for my own dotfiles?

If you like my installer script, I encourage you to fork this project, and replace my dotfiles with yours.

# Contributing

If you have suggestions for improvements or bug fixes, please feel free to open an issue or a pull request.
This has been my favorite (and most useful) personal project, and I'd love to make it useful for other people.
