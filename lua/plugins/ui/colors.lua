-- ~/.config/nvim/lua/plugins/init.lua
return {
	{
		"AlphaTechnolog/pywal.nvim",
		as = "pywal",
		config = function()
			require("pywal").setup()
		end,
	},
}
