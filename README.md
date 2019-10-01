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
$ ~/.dotfiles/install -y
```
to accept all the default options without being asked.

Installing this will create symlinks in your home directory to each file in `universal`,
and any appropriate files in `platform_specific`.
If these files already exist, you will be prompted to replace them (unless run with `-y`).
If you elect to replace them (or run with `-y`), they will be renamed with `.backup` at
the end of their name before the new version is symlinked.
