-- ~/.config/nvim/lua/mappings/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local M = {}

-- General mappings
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-q>", ":q<CR>", opts)

-- Nvim-tree toggle (Ctrl+N)
map("n", "<C-n>", ":Oil<CR>", opts)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fo", ":Telescope oldfiles<CR>", { desc = "See recent files" })
map("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "See diagnostics" })
map("n", "<leader>fc", ":Telescope git_commits<CR>", { desc = "Find commits" })
map("n", "<leader>ft", ":Telescope git_status<CR>", { desc = "See git status" })

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
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- LSP (General)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

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

-- Completion mappings (for cmp setup)
function M.cmp_mappings()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	return cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),

		-- Tab to select next item or expand snippet
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Shift-Tab to select previous item or jump backwards in snippet
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	})
end

return M
