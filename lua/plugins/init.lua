local M = {}

-- Plugin module definitions
local modules = {
	"plugins.completion",
	"plugins.lsp.languages.jdlts",
	"plugins.lsp.plugins",
	"plugins.utility",
	"plugins.ui",
}

function M.load_plugins()
	local plugins = {}

	for _, module in ipairs(modules) do
		local ok, mod = pcall(require, module)
		if ok and mod then
			vim.list_extend(plugins, mod)
		else
			vim.notify("Failed to load plugin module: " .. module, vim.log.levels.WARN)
		end
	end

	require("lazy").setup(plugins)
end

function M.setup_lsp()
	-- LSP configuration
end

function M.setup_plugins()
	-- Trouble setup
	require("trouble").setup()
	require("mini.files").setup({})
	-- Neopywal setup
	require("neopywal").setup({
		use_wallust = true,
	})
	vim.cmd.colorscheme("neopywal")
	local has_lualine, lualine = pcall(require, "lualine")
	if not has_lualine then
		return
	end

	local has_neopywal, neopywal_lualine = pcall(require, "neopywal.theme.plugins.lualine")
	if not has_neopywal then
		return
	end

	neopywal_lualine.setup()

	-- Colorizer setup
	require("colorizer").setup()

	-- Tiny inline diagnostic setup
	require("tiny-inline-diagnostic").setup({
		preset = "amongus",
		options = {
			add_messages = {
				display_count = true,
			},
			multilines = {
				enabled = true,
			},
			show_source = {
				if_many = true,
			},
		},
	})
end

function M.setup_diagnostics()
	-- Diagnostic configuration
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "✘",
				[vim.diagnostic.severity.WARN] = "▲",
				[vim.diagnostic.severity.INFO] = "»",
				[vim.diagnostic.severity.HINT] = "⚑",
			},
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
	})
end

function M.setup_undo()
	-- Persistent undo configuration
	vim.o.undofile = true

	local undodir = vim.fn.stdpath("data") .. "/undo"
	if vim.fn.isdirectory(undodir) == 0 then
		vim.fn.mkdir(undodir, "p")
	end

	vim.o.undodir = undodir
	vim.o.undolevels = 1000
	vim.o.undoreload = 10000
end

function M.setup_latex()
	-- LaTeX-specific completion
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

	capabilities = vim.tbl_deep_extend("force", capabilities, {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	})
end

function M.init()
	-- Load everything in order
	M.load_plugins()
	M.setup_plugins()
	M.setup_lsp()
	M.setup_diagnostics()
	M.setup_undo()
	M.setup_latex()
end

return M
