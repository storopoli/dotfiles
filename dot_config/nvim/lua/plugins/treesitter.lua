return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufRead",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"help",
				"lua",
				"javascript",
				"rust",
				"markdown",
				"bash",
				"yaml",
				"toml",
				"julia",
				"python",
				"latex",
				"bibtex",
				"regex",
			},
			sync_install = false,
			auto_install = true,
			autopairs = {
				enable = true,
			},
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { "" }, -- list of language that will be disabled
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true, disable = { "python" } },
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		})
	end,
}
