-- ~/.config/nvim/lua/mappings/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General mappings
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("n", "<C-q>", ":q<CR>", { desc = "Quit" })

-- Nvim-tree toggle (Ctrl+N)
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })

-- ToggleTerm
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Substitute
map({ "n", "x" }, "<leader>fs", function()
	require("rip-substitute").sub()
end, { desc = "Search and replace with rip-substitute" })

-- Diagnostics
map("n", "<leader>de", "<cmd>TinyInlineDiag enable<cr>", { desc = "Enable diagnostics" })
map("n", "<leader>dd", "<cmd>TinyInlineDiag disable<cr>", { desc = "Disable diagnostics" })
map("n", "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" })

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- LSP (General)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Java LSP (jdtls)
map("n", "<A-o>", function()
	require("jdtls").organize_imports()
end, { desc = "Organize imports" })

map("n", "<leader>ev", function()
	require("jdtls").extract_variable()
end, { desc = "Extract variable" })

map("v", "<leader>ev", function()
	require("jdtls").extract_variable(true)
end, { desc = "Extract variable (visual)" })

map("n", "<leader>ec", function()
	require("jdtls").extract_constant()
end, { desc = "Extract constant" })

map("v", "<leader>ec", function()
	require("jdtls").extract_constant(true)
end, { desc = "Extract constant (visual)" })

map("v", "<leader>em", function()
	require("jdtls").extract_method(true)
end, { desc = "Extract method" })

map("n", "<C-c>", function()
	require("jdtls").compile()
end, { desc = "Compile Java file" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
