-- Dracula everywhere: tmux (@plugin 'dracula/tmux') and ghostty (theme = Dracula)
-- both use it, so neovim matches.
return {
  { "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
  { "LazyVim/LazyVim", opts = { colorscheme = "dracula" } },
}
