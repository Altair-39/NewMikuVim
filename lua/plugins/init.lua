-- ~/.config/nvim/lua/plugins/init.lua
local plugins = {}

-- List your modules
local modules = {
	"plugins.completion",
	"plugins.lsp.languages.jdlts",
	"plugins.lsp.plugins",
	"plugins.utility",
	"plugins.ui",
}

for _, module in ipairs(modules) do
	local ok, mod = pcall(require, module)
	if ok and mod then
		vim.list_extend(plugins, mod)
	else
		vim.notify("Failed to load plugin module: " .. module, vim.log.levels.WARN)
	end
end

require("lazy").setup(plugins)

local neopywal = require("neopywal")
require("neopywal").setup({
	use_wallust = true,
})
vim.cmd.colorscheme("neopywal")
-- Executed after plugins are loaded
require("plugins.lsp.on-attach")     -- keymaps & autoformat
require("plugins.lsp.languages.c")   -- lua_ls configuration
require("plugins.lsp.languages.lua") -- lua_ls configuration
require("colorizer").setup({
	"css",
	"javascript",
	html = {
		mode = "foreground",
	},
})

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({
	signs = {
		-- you can set custom symbols/text for each severity
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.INFO] = "»",
			[vim.diagnostic.severity.HINT] = "⚑",
		},
		-- optional: highlight groups for signs, etc. Usually the default texthl is fine
		-- texthl = {
		--   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
		--   [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
		--   [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
		--   [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
		-- },
		-- you can also set priority, or turn off signs per severity, etc.
		-- priority = <number>, -- default is something like 10
	},
	-- other diagnostic settings:
	update_in_insert = false,
	underline = true,
	virtual_text = {
		spacing = 2,
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	severity_sort = true,
})
-- Enable persistent undo
vim.o.undofile = true

-- Set a directory to store undo files
local undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.o.undodir = undodir

-- Optional: nicer undo behavior
vim.o.undolevels = 1000  -- how many undo steps to keep
vim.o.undoreload = 10000 -- max lines to save for undo

-- latex
local cmp = require("cmp")

cmp.setup.filetype("tex", {
	sources = {
		{ name = "path" }, -- enables filesystem completion (for \include{…})
		{ name = "buffer" },
		{ name = "luasnip" },
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
})
