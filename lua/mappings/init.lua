-- ~/.config/nvim/lua/mappings/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General mappings
map("n", "<C-s>", ":w<CR>", opts) -- Ctrl+S to save
map("n", "<C-q>", ":q<CR>", opts) -- Ctrl+Q to quit

-- Nvim-tree toggle (Ctrl+N)
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- ToggleTerm
map("n", "<leader>tt", ":ToggleTerm<CR>", opts)

-- navigate buffers easily
map("n", "<Tab>", ":bnext<CR>", { silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
map("n", "<leader>bd", ":bdelete<CR>", { silent = true })

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "K", vim.lsp.buf.hover, opts)
