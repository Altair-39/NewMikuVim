return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"vim",
				"regex",
				"bash",
				"lua",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
		})
	end,
}
