-- Lazy config
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Vim Config
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.rtp:prepend(lazypath)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>", { desc = "Reveal filesystem in Neotree" })
vim.keymap.set("n", "<C-h>", "<C-w>h<CR>", { desc = "Move to window on the left" })
vim.keymap.set("n", "<C-j>", "<C-w>j<CR>", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k<CR>", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l<CR>", { desc = "Move to window on the right" })
vim.keymap.set("n", "<C-t>", ":tab terminal<CR>", { desc = "Open new terminal" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format, { desc = "Format current file" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show function information" })
vim.keymap.set("n", "gd", function()
  vim.cmd("set splitright")
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Open function definition in a split window" })

vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", { desc = "Escape terminal mode" })

-- Import plugins
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
