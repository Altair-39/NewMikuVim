return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("tiny-inline-diagnostic").setup()

		vim.api.nvim_create_autocmd("User", {
			pattern = "TinyInlineDiagnosticReady",
			once = true,
			callback = function()
				vim.cmd("TinyInlineDiagnostic enable")
			end,
		})
	end,
}
