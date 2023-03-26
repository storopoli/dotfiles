return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer

		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					-- apply whatever logic you want (in this example, we'll only use null-ls)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		local cmp = require("cmp")

		-- if you want to set up formatting on save, you can use this as a callback
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		
		-- Keybindings	
		local on_attach = function(client, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end


			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, {
				desc = "Format current buffer with LSP",
			})
			nmap("<leader>fo", vim.lsp.buf.format or vim.lsp.buf.formatting, "[Fo]rmat current buffer with LSP")
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
		end

		-- Add additional capabilities supported by nvim-cmp
		-- nvim hasn't added foldingRange to default capabilities, users must add it manually
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local nvim_lsp = require("lspconfig")

		---------------------
		-- setup languages --
		---------------------

		-- GoLang
		nvim_lsp.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				gopls = {
					experimentalPostfixCompletions = true,
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
				},
			},
			init_options = {
				usePlaceholders = true,
			},
		})

		-- C/C++
		nvim_lsp.clangd.setup({})

		-- Julia
		nvim_lsp.julials.setup({})

		-- Python
		nvim_lsp.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "off",
					},
				},
			},
		})

		-- Lua Language Server
		nvim_lsp.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- Rust
		nvim_lsp.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- Webdev stuff
		nvim_lsp.html.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		nvim_lsp.cssls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		nvim_lsp.tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- Bash
		nvim_lsp.bashls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- LaTeX
		nvim_lsp.texlab.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "texlab" },
			filetypes = { "tex", "bib", "plaintex" },
			settings = {
				texlab = {
					build = {
						executable = "tectonic",
						args = {
							"-X", "compile", "%f",
							"--synctex",
							"--keep-logs",
							"--keep-intermediates",
						},
						isContinuous = false,
						onSave = true,
					},
					formatterLineLength = 80,
					latexFormatter = "texlab",
				},
			},
		})

		--------
		-- UI --
		--------
		--Change diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		vim.diagnostic.config({
			-- virtual_text = {
			-- 	source = "always", -- Or "if_many"
			-- },
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = false,
			float = {
				source = "always", -- Or "if_many"
			},
		})
	end,
}
