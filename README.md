# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a
package whose layout mirrors `$HOME`; stowing it symlinks the files into `$HOME`.

## Packages

| Package   | Links to                  | Needs at runtime                       |
| --------- | ------------------------- | -------------------------------------- |
| `git`     | `~/.gitconfig`            | `git-lfs` (config declares lfs filters) |
| `tmux`    | `~/.tmux.conf`            | `tmux`, tpm + plugins (see below)      |
| `vim`     | `~/.vimrc`                | `vim`, vim-plug, `node`, `ag`          |
| `ghostty` | `~/.config/ghostty/config` | ghostty (client-side terminal)         |

## Bootstrap a new machine

### 1. Dependencies

**Ubuntu / Debian / WSL**

```sh
sudo apt update
sudo apt install -y stow git vim tmux curl \
                    nodejs npm silversearcher-ag git-lfs
```

**macOS**

```sh
brew install stow git vim tmux node the_silver_searcher git-lfs
```

`node` is required by `coc.nvim`; `ag` (the_silver_searcher) backs `$FZF_DEFAULT_COMMAND`.
`fzf` itself is **not** installed here — vim-plug builds it into `~/.fzf`.

### 2. Clone and stow

```sh
git clone https://github.com/mtmckenna/dotfiles ~/workspace/dotfiles
cd ~/workspace/dotfiles
stow git tmux vim ghostty
```

`.stowrc` sets `--target=$HOME`, so always run `stow` from inside the repo.

Stow refuses to overwrite a real file. If one already exists at a target, either move it
aside or adopt it into the repo:

```sh
stow --adopt git    # pulls the existing file into the repo, then symlinks; check `git diff`
```

`--adopt` **overwrites the repo's copy with the machine's copy**, so always
`git diff` afterward and revert if the incoming version isn't what you want.

### 3. tmux plugins

The config drives plugins through [tpm](https://github.com/tmux-plugins/tpm), which is not
vendored. Clone it, then install:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

Or from inside tmux: `prefix + I`. Later: `prefix + U` updates, `prefix + alt-u` prunes
plugins no longer listed in the config.

### 4. vim plugins

Install vim-plug and create the swap directory the config points at
(`set directory=~/.vim/tmp` — vim errors on every file if it's missing):

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.vim/tmp
vim +PlugInstall +qall
```

Then verify coc can see node: `vim +'checkhealth' +qall`, or `:CocInfo` inside vim.

## Machine-local config

Some settings are per-machine and must **not** live in a stowed file, or they get committed
and follow you to every other box. Git reads `~/.config/git/config` in addition to
`~/.gitconfig`, so machine-local git settings belong there, leaving the stowed
`~/.gitconfig` symlink clean.

The most common case is the GitHub CLI credential helper. `gh auth setup-git` writes it into
`~/.gitconfig`, which would dirty the symlink — write it to the XDG file instead:

```sh
mkdir -p ~/.config/git
cat >> ~/.config/git/config <<'EOF'
[credential "https://github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
[credential "https://gist.github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
EOF
```

Confirm what's coming from where:

```sh
git config --show-origin --get-all credential.https://github.com.helper
```

## Notes and gotchas

- **tmux 3.5+ options.** `extended-keys-format` only exists in tmux 3.5 and later; Ubuntu
  24.04 ships 3.4. It's wrapped in `%if #{>=:#{version},3.5}` so older tmux doesn't print
  `invalid option` on every start. Guard any other new option the same way.
- **Clipboard over ssh/mosh.** The config emits OSC 52 so copies reach the *local*
  terminal's clipboard. If a mouse drag doesn't copy, hold Shift to bypass tmux mouse mode.
- **ghostty under WSL.** ghostty runs on the client side, so the binary usually isn't
  present in WSL. Stowing the package is still harmless — the config is just staged.
- **vim-prettier** uses `'do': 'npm install'`. If you'd rather use yarn, note yarn isn't in
  Ubuntu's default repos and needs its own install.

## Stow commands

```sh
stow <pkg>       # link
stow -D <pkg>    # unlink
stow -R <pkg>    # relink (after moving files around in the repo)
stow -n -v <pkg> # dry run — always worth running first
```

## Add a new config

Recreate the path relative to `$HOME` inside a new package directory, move the real files
in, then stow:

```sh
mkdir -p nvim/.config/nvim
mv ~/.config/nvim/* nvim/.config/nvim/
stow nvim
```

Then add it to the Packages table above.
