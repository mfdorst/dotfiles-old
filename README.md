# Instructions

Clone this repository into `~/.dotfiles`:

```
$ git clone https://github.com/mfdorst/dotfiles ~/.dotfiles
```

and run

```
$ ~/.dotfiles/install.sh
```

or

```
$ ~/.dotfiles/install.sh -y
```
to accept all the default options without being asked.
_Note that this may overwrite existing dotfiles without warning._

Installing this will create symlinks in your home directory to each file in `universal`,
and any appropriate files in `platform_specific`.
If these files already exist, you will be prompted to replace them. If you want to
back up your current version, run

```
$ mv myfile myfile_backup
```

for each file you want to save a copy of.

