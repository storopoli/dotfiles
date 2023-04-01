-- remap space as leader key
vim.g.mapleader = " "

-- modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- nvim file explorer
vim.keymap.set("n", "<leader>t", vim.cmd.Ex)

-- navigate buffers --
vim.keymap.set("n", "<TAB>", ":bnext<CR>")
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>")

-- stay in indent mode --
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move text up and down --
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":move '<-2<CR>gv=gv")

-- adjust the direction of the split screen --
-- vim.keymap.set("n", ",", "<C-w>t<C-w>K")
-- vim.keymap.set("n", ".", "<C-w>t<C-w>H")

-- better movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- resize the window --
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- better search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- tabnew
vim.keymap.set("n", "<C-n>", ":tabnew<CR>")

-- easy save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
-- easy Quit
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>")

-- global yank/paste
vim.keymap.set("n", "<leader>y", '"*y :let @+=@*<CR>')
vim.keymap.set("v", "<leader>y", '"*y :let @+=@*<CR>')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')

-- misc
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
