# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a
package whose layout mirrors `$HOME`; stowing it symlinks the files into `$HOME`.

Editing is **Neovim + [LazyVim](https://www.lazyvim.org/)**. The `vim` package is a
zero-dependency fallback for quick edits, rescue shells, and boxes where installing neovim
isn't worth it.

## Packages

| Package   | Links to                   | Needs at runtime                          |
| --------- | -------------------------- | ----------------------------------------- |
| `nvim`    | `~/.config/nvim`           | neovim ≥ 0.11.2, `rg`, `fd`, `node`, C compiler |
| `git`     | `~/.gitconfig`             | `git-lfs` (config declares lfs filters)   |
| `tmux`    | `~/.tmux.conf`             | `tmux`, tpm + plugins                     |
| `vim`     | `~/.vimrc`, `~/.vim/`      | stock `vim` only — no plugins, no node    |
| `ghostty` | `~/.config/ghostty/config` | ghostty (client-side terminal)            |

## Bootstrap a new machine

### 1. Neovim

**Do not use `apt install neovim`** — Ubuntu 24.04 ships 0.9.5 and LazyVim requires
**0.11.2+**. Install the official tarball into `~/.local` (no sudo needed):

```sh
curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
rm -rf ~/.local/nvim && mv nvim-linux-x86_64 ~/.local/nvim
mkdir -p ~/.local/bin && ln -sf ~/.local/nvim/bin/nvim ~/.local/bin/nvim
```

Make sure `~/.local/bin` is on `PATH` (`~/.profile` does this by default).

On macOS: `brew install neovim` is current enough.

### 2. System packages

```sh
# Ubuntu / Debian / WSL
sudo apt update
sudo apt install -y stow git tmux vim curl build-essential \
                    ripgrep fd-find nodejs npm git-lfs

# Debian/Ubuntu ship fd as `fdfind`; LazyVim looks for `fd`
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
```

```sh
# macOS
brew install stow git tmux vim neovim ripgrep fd node git-lfs lazygit fzf tree-sitter
```

`rg` and `fd` back LazyVim's file/grep pickers; `node` backs the TypeScript/JSON LSPs and
prettier. **Watch out:** if `rg` seems present but LazyVim reports it missing, check
`type -a rg` — a shell *function* (some tools inject one) is invisible to neovim, which only
resolves real binaries on `PATH`.

### 3. User-local binaries (no sudo)

Not packaged, or too old in apt. All install to `~/.local/bin`:

```sh
# tree-sitter CLI - LazyVim health errors without it
curl -fsL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz \
  | gunzip > ~/.local/bin/tree-sitter && chmod +x ~/.local/bin/tree-sitter

# lazygit - bound to <leader>gg in LazyVim
curl -fsL "$(curl -sL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
  | grep -oE 'https://[^"]*linux_x86_64\.tar\.gz')" | tar xz -C ~/.local/bin lazygit

# fzf (also used by the vim fallback, which installs it to ~/.fzf)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
ln -sf ~/.fzf/bin/fzf ~/.local/bin/fzf
```

The `~/.fzf/install` script appends a `source ~/.fzf.bash` line to `~/.bashrc`, which only
affects interactive shells — hence the extra symlink so neovim sees `fzf` too.

### 4. Clone and stow

```sh
git clone https://github.com/mtmckenna/dotfiles ~/workspace/dotfiles
cd ~/workspace/dotfiles
stow nvim git tmux vim ghostty
```

`.stowrc` sets `--target=$HOME`, so always run `stow` from inside the repo.

Stow refuses to overwrite a real file. If one already exists at a target, move it aside or
adopt it into the repo:

```sh
stow --adopt git    # pulls the existing file into the repo, then symlinks
```

`--adopt` **overwrites the repo's copy with the machine's copy**, so always `git diff`
afterward and revert if the incoming version isn't what you want.

### 5. LazyVim plugins

```sh
nvim --headless "+Lazy! sync" +qa
nvim --headless "+checkhealth lazyvim" +qa   # confirm nothing's missing
```

LSP servers install themselves through Mason on first use of a filetype.

### 6. tmux plugins

tpm isn't vendored — clone it, then install:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

From inside tmux: `prefix + I` installs, `prefix + U` updates, `prefix + alt-u` prunes.

### 7. vim fallback

Nothing to do — `stow vim` is the whole install. The package is deliberately
dependency-free: no plugin manager, no node, no external binaries. Dracula is vendored into
`vim/.vim/colors/` (MIT, see `LICENSE-dracula`) so it works offline on a fresh box, and the
swap directory is created on demand by the vimrc.

Don't add a `Plug` block back to it — plugins belong in the `nvim` package.

## Machine-local config

Per-machine settings must **not** live in a stowed file, or they get committed and follow you
everywhere. Git reads `~/.config/git/config` in addition to `~/.gitconfig`, so machine-local
git settings go there, leaving the stowed `~/.gitconfig` clean.

The usual case is the GitHub CLI credential helper. `gh auth setup-git` writes it into
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

git config --show-origin --get-all credential.https://github.com.helper   # verify
```

## Notes and gotchas

- **Clipboard on WSL.** There's no X clipboard and win32yank isn't installed, so
  `lua/config/options.lua` routes neovim copies out over **OSC 52** — the same path
  `.tmux.conf` already enables (`set-clipboard on`). Works through tmux, over ssh/mosh, and
  in ghostty. Paste deliberately does *not* use OSC 52 (most terminals refuse clipboard
  reads and the query hangs) and falls back to the last yank register. For true
  bidirectional Windows↔nvim clipboard, install `win32yank.exe` and delete that block —
  neovim autodetects it on WSL.
- **tmux 3.5+ options.** `extended-keys-format` only exists in tmux 3.5+; Ubuntu 24.04 ships
  3.4. It's wrapped in `%if #{>=:#{version},3.5}` so older tmux doesn't print `invalid
  option` on every start. Guard any other new option the same way.
- **Dracula everywhere.** neovim, tmux and ghostty all use it; change all three together.
- **ghostty under WSL.** ghostty runs client-side, so the binary usually isn't present in
  WSL. Stowing the package is harmless — the config is just staged.

## Stow commands

```sh
stow <pkg>       # link
stow -D <pkg>    # unlink
stow -R <pkg>    # relink (after moving files around in the repo)
stow -n -v <pkg> # dry run - always worth running first
```

## Add a new config

Recreate the path relative to `$HOME` inside a new package directory, move the real files in,
then stow:

```sh
mkdir -p foo/.config/foo
mv ~/.config/foo/* foo/.config/foo/
stow foo
```

Then add it to the Packages table above.
