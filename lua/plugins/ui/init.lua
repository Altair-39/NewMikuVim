-- lua/plugins/ui/init.lua
local modules = {
	require("plugins.ui.nvimtree"),
	require("plugins.ui.colors"),
	require("plugins.ui.noice"),
	require("plugins.ui.lualine"),
	require("plugins.ui.barbar"),
	require("plugins.ui.alpha"),
}

local plugins = {}
for _, mod in ipairs(modules) do
	if type(mod) == "table" then
		vim.list_extend(plugins, mod)
	end
end

return plugins
