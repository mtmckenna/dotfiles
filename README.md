# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a
package whose layout mirrors `$HOME`; stowing it symlinks the files into `$HOME`.

## Packages

- `git` → `~/.gitconfig`
- `tmux` → `~/.tmux.conf`
- `ghostty` → `~/.config/ghostty/config`

## Install

```sh
brew install stow
git clone https://github.com/mtmckenna/dotfiles ~/workspace/dotfiles
cd ~/workspace/dotfiles
stow git tmux ghostty
```

`.stowrc` sets `--target=$HOME`, so run `stow` from inside the repo. If a real file already
exists at a target, adopt it instead:

```sh
stow --adopt git    # pulls the existing file into the repo, then symlinks; check `git diff`
```

## Commands

```sh
stow <pkg>       # link
stow -D <pkg>    # unlink
stow -R <pkg>    # relink
stow -n -v <pkg> # dry run
```

## Add a new config

```sh
mkdir -p nvim/.config/nvim
mv ~/.config/nvim/* nvim/.config/nvim/
stow nvim
```
