-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Carried over from the pre-LazyVim .vimrc. tabstop/shiftwidth=2, expandtab,
-- number and nowrap are already LazyVim defaults; set explicitly so the intent
-- survives any future LazyVim default change.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.wrap = false

-- WSL has no X clipboard and win32yank isn't installed, so route copies out
-- over OSC 52 -- the same escape-sequence path .tmux.conf already enables
-- (set-clipboard on). This works through tmux, over ssh/mosh, and in ghostty.
--
-- Paste is deliberately NOT OSC 52: most terminals refuse clipboard *reads*,
-- and a blocking query makes `p` hang. Instead paste falls back to the last
-- yank register. For true bidirectional Windows<->nvim clipboard, install
-- win32yank.exe and delete this block -- neovim autodetects it on WSL.
local osc52 = require("vim.ui.clipboard.osc52")
local function paste_from_unnamed()
  return vim.split(vim.fn.getreg('"') or "", "\n")
end
vim.g.clipboard = {
  name = "OSC 52",
  copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
  paste = { ["+"] = paste_from_unnamed, ["*"] = paste_from_unnamed },
}
