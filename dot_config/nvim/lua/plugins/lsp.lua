return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",

		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"kdheepak/cmp-latex-symbols",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset("recommended")

		-- fix texlab to work with tectonic only
		lsp.configure("texlab", {
			cmd = { "texlab" },
			filetypes = { "tex", "bib" },
			settings = {
				texlab = {
					build = {
						executable = "tectonic",
						args = {
							"-X",
							"build",
						},
						isContinuous = false,
						onSave = true,
					},
					formatterLineLength = 80,
					latexFormatter = "texlab",
				},
			},
		})

		-- fix Undefined global 'vim'
		lsp.configure("lua_ls", {
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = {
						-- Fix Undefined global 'vim'
						globals = { "vim" },
					},
				},
			},
		})

		-- all other LSPs default configs
		lsp.configure("tsserver", {})
		lsp.configure("bashls", {})
		lsp.configure("julials", {})
		lsp.configure("pyright", {})

		-- completion
		vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		})

		-- I like my tabs, but I should stop doing this
		cmp_mappings["<Tab>"] = nil
		cmp_mappings["<S-Tab>"] = nil

		-- include latex symbols please
		local cmp_sources = lsp.defaults.cmp_sources()
		table.insert(cmp_sources, {
			name = "latex_symbols",
			option = {
				strategy = 1, -- julia
			},
		})

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings,
			sources = cmp_sources,
		})

		lsp.set_preferences({
			suggest_lsp_servers = false,
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format()
			end, opts)
		end)

		lsp.setup()

		vim.diagnostic.config({
			virtual_text = true,
		})
	end,
}
