-- lua/plugins/utility/init.lua
local mods = {
	"plugins.utility.toggleterm",
	"plugins.utility.colorizer",
	"plugins.utility.autopairs",
	"plugins.utility.which-key",
	"plugins.utility.telescope",
	"plugins.utility.substitute",
	"plugins.utility.treesitter",
	"plugins.utility.diagnostic",
	"plugins.utility.render-markdown",
	"plugins.lsp.languages.rust",
	"plugins.utility.rustaceanvim",
	"plugins.lsp.languages.latex",
	--	"plugins.lsp.languages.jdlts",
}
local plugins = {}
for _, mod_name in ipairs(mods) do
	local ok, mod = pcall(require, mod_name)
	if ok and type(mod) == "table" then
		vim.list_extend(plugins, mod)
	else
		vim.notify("Module " .. mod_name .. " did not return a table")
	end
end

return plugins
