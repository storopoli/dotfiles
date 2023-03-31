return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", vim.cmd.Git },
	},
	event = "VeryLazy",
	config = function()
		local fugitive = vim.api.nvim_create_augroup("fugitive", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = fugitive,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git('push')
				end, opts)

				-- rebase always
				vim.keymap.set("n", "<leader>P", function()
					vim.cmd.Git({ 'pull', '--rebase' })
				end, opts)

				-- NOTE: it allows me to easily set the branch i am pushing and any tracking
				-- needed if i did not set the branch up correctly
				vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);

				-- better diffs with gh and gl
				-- enter the merge conflicts with figitive `dv`
				-- then chose the left or the right with `gh` or `gl`, respectively
				vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
				vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
			end,
		})
	end
}
