return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local code_actions = null_ls.builtins.code_actions
		local completion = null_ls.builtins.completion
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		local hover = null_ls.builtins.hover
		require("null-ls").setup({		
			sources = {
				-- you must download code formatter by yourself!
				formatting.stylua,
				formatting.black,
				formatting.prettier,
				formatting.gofmt,
				formatting.rustfmt,
				diagnostics.todo_comments,
				diagnostics.shellcheck.with({ method = null_ls.methods.DIAGNOSTICS_ON_SAVE }),
			},
		})
	end,
}
