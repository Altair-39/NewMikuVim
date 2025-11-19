return {
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.maplocalleader = "\\" -- keybinding prefix
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_view_method = "zathura"

			-- Build options
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "PDF", -- logical directory for vimtex
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				options = {
					"-pdf", -- generate PDF
					"-interaction=nonstopmode",
					"-synctex=1",
					"-outdir=PDF", -- <<< THIS makes latexmk write there
				},
			}

			vim.g.vimtex_fold_enabled = 1
		end,
	},

	"evesdropper/luasnip-latex-snippets.nvim",
}
