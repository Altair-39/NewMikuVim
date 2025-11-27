-- ~/.config/nvim/lua/mappings/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local M = {}

-- General mappings
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-q>", ":q<CR>", opts)

-- Dropbar
map("n", "<Leader>;", function()
	require("dropbar.api").pick()
end, { desc = "Pick symbols in winbar" })
map("n", "[;", function()
	require("dropbar.api").goto_context_start()
end, { desc = "Go to start of current context" })
map("n", "];", function()
	require("dropbar.api").select_next_context()
end, { desc = "Select next context" })

-- Replace Oil with mini.files
local minifiles_toggle = function(...)
	if not MiniFiles.close() then
		MiniFiles.open(...)
	end
end
map("n", "<C-n>", minifiles_toggle, opts)
map("n", "<leader>-", function()
	require("mini.files").toggle_float()
end)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fo", ":Telescope oldfiles<CR>", { desc = "See recent files" })
map("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "See diagnostics" })
map("n", "<leader>fc", ":Telescope git_commits<CR>", { desc = "Find commits" })
map("n", "<leader>ft", ":Telescope git_status<CR>", { desc = "See git status" })

-- Harpoon
map("n", "<leader>ha", function()
	require("harpoon.mark").add_file()
end, { desc = "Harpoon add file" })
map("n", "<leader>hh", function()
	require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon menu" })
map("n", "<leader>1", function()
	require("harpoon.ui").nav_file(1)
end, { desc = "Harpoon to file 1" })
map("n", "<leader>2", function()
	require("harpoon.ui").nav_file(2)
end, { desc = "Harpoon to file 2" })
map("n", "<leader>3", function()
	require("harpoon.ui").nav_file(3)
end, { desc = "Harpoon to file 3" })
map("n", "<leader>4", function()
	require("harpoon.ui").nav_file(4)
end, { desc = "Harpoon to file 4" })
map("n", "<leader>5", function()
	require("harpoon.ui").nav_file(5)
end, { desc = "Harpoon to file 5" })
map("n", "<leader>ht", function()
	require("telescope").extensions.harpoon.marks(require("telescope.themes").get_dropdown({}))
end, { desc = "Harpoon telescope" })

-- Navigate between harpoon marks
map("n", "<A-p>", function()
	require("harpoon.ui").nav_prev()
end, { desc = "Harpoon previous" })
map("n", "<A-n>", function()
	require("harpoon.ui").nav_next()
end, { desc = "Harpoon next" })

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

-- Blink shell mappings (for blink setup)
function M.blink_mappings()
	local blink = require("blink")

	return {
		-- Confirm selection (similar to <CR> in cmp)
		["\r"] = blink.mapping.confirm_select,

		-- Trigger completion (similar to <C-Space> in cmp)
		["\x1b "] = blink.mapping.show_completions, -- Ctrl+Space

		-- Tab to select next item
		["\t"] = blink.mapping.select_next_item,

		-- Shift-Tab to select previous item
		["\x1b[Z"] = blink.mapping.select_prev_item,

		-- Additional useful Blink mappings
		["\x1b[A"] = blink.mapping.navigate_up, -- Up arrow
		["\x1b[B"] = blink.mapping.navigate_down, -- Down arrow
		["\x1b[C"] = blink.mapping.navigate_right, -- Right arrow
		["\x1b[D"] = blink.mapping.navigate_left, -- Left arrow

		-- Cycle through completion sources
		["\x1b\t"] = blink.mapping.cycle_sources,
	}
end

return M
