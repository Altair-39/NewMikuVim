-- ~/.config/nvim/lua/plugins/completion/setup.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = require("mappings").cmp_mappings(), -- Reference mappings from separate file
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})
