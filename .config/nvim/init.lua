-------------------------------------------------------------------------------
-- DEPENDENCIES
-- neovim nodejs ripgrep rust-analyzer

-- 22 Plugins
-- ~20ms startup
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.o.nu = true
vim.o.relativenumber = true

-- Tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Lazy redraw for crazy macros
--vim.opt.lazyredraw = true

-- A lot of plugins depends on hidden true
vim.o.hidden = true

-- set command line height to zero/two lines
-- vim.opt.cmdheight = 2
vim.o.cmdheight = 0

-- Statusbar
vim.o.laststatus = 3

-- Winbar on top of the windows
vim.o.winbar = "%=%m %f"

-- Enable mouse mode
vim.o.mouse = "a"

-- Scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Time in milliseconds to wait for a mapped sequence to complete
vim.o.timeoutlen = 500
vim.o.ttyfast = true

-- No wrap
vim.o.wrap = false

-- Enable break indent
vim.o.breakindent = true

-- Better undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "undo"
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 500
vim.wo.signcolumn = "yes"

-- color column
vim.o.colorcolumn = "80"

-- Window splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Transparency
vim.o.winblend = 5

-- If enabled, Neovim will search for the following files in the current directory:
-- - .nvim.lua
-- - .nvimrc
-- - .exrc
-- Add files with `:trust`, remove with `:trust ++remove`
vim.o.exrc = true

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "Q", "<nop>")

-- File explorer
vim.keymap.set("n", "<C-p>", vim.cmd.Ex)

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Splits
vim.keymap.set("n", "<leader>|", "<C-W>v", { remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { remap = true })

-- Better movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set("n", "<leader>R", "<CMD>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>")

-- J/K to move up/down visual lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==")
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- Easy save
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true })

-- Easy Quit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { silent = true })
vim.keymap.set("n", "<leader>Q", "<CMD>qa!<CR>", { silent = true })

-- Global Yank/Paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true })
vim.keymap.set("x", "<leader>p", '"+p', { noremap = true, silent = true })

-------------------------------------------------------------------------------
--  Netrw Customizations
-------------------------------------------------------------------------------

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        -- edit new file
        vim.keymap.set("n", "n", "%", { remap = true, buffer = true })
        -- rename file
        vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
    end,
})

-------------------------------------------------------------------------------
--  Highlight on Yank
-------------------------------------------------------------------------------
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-------------------------------------------------------------------------------
-- Restore Cursors
-------------------------------------------------------------------------------
-- See `:help restore-cursor`
local restore_group = vim.api.nvim_create_augroup("RestoreGroup", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
    command = [[call setpos(".", getpos("'\""))]],
    group = restore_group,
    pattern = "*",
})

-------------------------------------------------------------------------------
-- Bootstrap Package Manager
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
require("lazy").setup({
    {
        "ellisonleao/gruvbox.nvim", -- Set colorscheme to Gruvbox Theme
        lazy = false,         -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,      -- make sure to load this before all
        config = function()
            require("gruvbox").setup({
                contrast_dark = "hard",
                transparent_mode = true,
            })
            vim.o.termguicolors = true
            vim.o.background = "dark"
            vim.cmd.colorscheme("gruvbox")
        end,
        keys = {
            { "<leader>l", "<cmd>Lazy<cr>", desc = "[L]azy" },
        },
    },
    {
        "nvim-telescope/telescope.nvim", -- Telescope
        branch = "0.1.x",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<leader>.", "<CMD>Telescope oldfiles<CR>" },
            { "<leader><space>", "<CMD>Telescope buffers<CR>" },
            {
              "<leader>/",
              function()
                require("telescope.builtin").current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                  winblend = 10,
                  previewer = false,
                })
              end,
            },
            {
              "<leader>s/",
              function()
                require("telescope.builtin").live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
              }
              end,
            },
            { "<leader>sr", "<CMD>Telescope resume<CR>" },
            { "<leader>sf", "<CMD>Telescope find_files<CR>" },
            { "<leader>sh", "<CMD>Telescope help_tags<CR>" },
            { "<leader>sw", "<CMD>Telescope grep_string<CR>" },
            { "<leader>sg", "<CMD>Telescope live_grep<CR>" },
            { "<leader>sd", "<CMD>Telescope diagnostics<CR>" },
            { "<leader>sm", "<CMD>Telescope marks<CR>" },
            { "<leader>sc", "<CMD>Telescope git_bcommits<CR>" },
            { "<leader>sC", "<CMD>Telescope git_commits<CR>" },
            { "<leader>ss", "<CMD>Telescope git_status<CR>" },
            { "<leader>sS", "<CMD>Telescope git_stash<CR>" },
            { "<leader>sT", "<CMD>Telescope git_stash<CR>" },
        },
        opts = {},
        config = function()
            -- See `:help telescope` and `:help telescope.setup()`
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-n>"] = "move_selection_next",
                            ["<C-p>"] = "move_selection_previous",
                            ["<C-f>"] = function(...)
                                return require("telescope.actions").preview_scrolling_down(...)
                            end,
                            ["<C-b>"] = function(...)
                                return require("telescope.actions").preview_scrolling_up(...)
                            end,
                        },
                        n = {
                            ["q"] = function(...)
                                return require("telescope.actions").close(...)
                            end,
                        },
                    },
                },
            })
        end,
    },
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/nvim-cmp", -- Autocompletion plugin
            "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
            "hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths
            "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API
            "petertriho/cmp-git", -- nvim-cmp source for git
            {
              "garymjr/nvim-snippets",
              opts = {
                friendly_snippets = true,
              },
              dependencies = { "rafamadriz/friendly-snippets" },
            },
            -- Copilot
            {
                "zbirenbaum/copilot.lua",
                cmd = "Copilot",
                build = ":Copilot auth",
                opts = {
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                    filetypes = {
                        markdown = true,
                        help = true,
                    },
                },
                keys = {
                    {
                        "<leader>cp",
                        function()
                            if require("copilot.client").is_disabled() then
                                vim.cmd("Copilot enable")
                            else
                                vim.cmd("Copilot disable")
                            end
                        end,
                        desc = "Co[p]ilot Toggle",
                    },
                },
            },
            {
                "zbirenbaum/copilot-cmp",
                dependencies = "copilot.lua",
                config = true,
            },
        },
        config = function()
            local lsp = require("lspconfig")
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[D]iagnostics: Goto Previous" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[D]iagnostics: Goto Next" })
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "[D]iagnostics: Op[e]n Float" })
            vim.keymap.set("n", "<leader>k", vim.diagnostic.setloclist, { desc = "[D]iagnostics: Set" })
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    -- Code Actions
                    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
                    -- Definitions
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
                    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
                    vim.keymap.set("n", "<leader>sD", require("telescope.builtin").lsp_document_symbols)
                    vim.keymap.set("n", "<leader>ss", require("telescope.builtin").lsp_dynamic_workspace_symbols)
                    -- See `:help K` for why this keymap
                    vim.keymap.set("n", "K", vim.lsp.buf.hover)
                    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
                    -- Lesser used LSP functionality
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition)
                    -- Format
                    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
                    -- The following autocommand is used to enable inlay hints in your
                    -- code, if the language server you are using supports them
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        vim.keymap.set("n", "<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end)
                    end
                end,
            })
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            -- Add additional capabilities supported by nvim-cmp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
            -- nvim-cmp setup
            local cmp = require("cmp")
            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
                      == nil
            end
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                preselect = cmp.PreselectMode.Item,
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                  ["<C-Space>"] = cmp.mapping.complete(),
                  ["<C-e>"] = cmp.mapping.abort(),
                  ["<C-n>"] = cmp.mapping.select_next_item(),
                  ["<C-p>"] = cmp.mapping.select_prev_item(),
                  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                  ['<C-l>'] = cmp.mapping(function(fallback)
                    if vim.snippet.active({ direction = 1 }) then
                      feedkey("<cmd>lua vim.snippet.jump(1)<CR>", "")
                    elseif cmp.visible() then
                      cmp.select_next_item()
                    elseif has_words_before() then
                      cmp.complete()
                    else
                      fallback()
                    end
                  end, { 'i', 's' }),
                  ['<C-h>'] = cmp.mapping(function()
                    if vim.snippet.active({ direction = -1 }) then
                      feedkey("<cmd>lua vim.snippet.jump(-1)<CR>", "")
                    elseif cmp.visible() then
                      cmp.select_prev_item()
                    end
                  end, { 'i', 's' }),
                }),
                sources = {
                    { name = "copilot", priority = 100 },
                    { name = "nvim_lsp" },
                    { name = "snippets" },
                    { name = "path" },
                },
            })
            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                    { name = "path" },
                }, {
                    { name = "buffer", keyword_length = 3 },
                }),
            })
            -- Use buffer source for `/` and `?`
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            -- Use path and cmdline source for `:` with TAB/Shift-TAB as autocomplete
            cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
              ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              ["<Tab>"] = cmp.mapping.select_next_item(),
            }),
            sources = cmp.config.sources({
                { name = "path" },
              }, {
                { name = "cmdline" },
              }),
            })
            require("cmp_git").setup()
            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
            lsp.rust_analyzer.setup({ capabilities = capabilities }) -- requires rust-analyzer to be installed
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "cpp",
                    "html",
                    "javascript",
                    "jsdoc",
                    "json",
                    "lua",
                    "luadoc",
                    "luap",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "rust",
                    "tsx",
                    "typescript",
                    "toml",
                    "vim",
                    "vimdoc",
                    "yaml",
                    "zig",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true, disable = { "python" } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-S>",
                        node_decremental = "<C-bs>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ["<leader>a"] = "@parameter.inner" },
                        swap_previous = { ["<leader>A"] = "@parameter.inner" },
                    },
                },
            })
        end,
    },
    {
        "j-hui/fidget.nvim", -- Status for LSP stuff
        tag = "legacy",
        event = "LspAttach",
        config = function()
            require("fidget").setup({
                window = {
                    blend = 0,
                },
            })
        end,
    },
    -- Git related plugins
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    -- Navigation
                    vim.keymap.set("n", "]h", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, buffer = bufnr, desc = "Next Hunk" })
                    vim.keymap.set("n", "[h", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, buffer = bufnr, desc = "Previous Hunk" })
                    -- Actions
                    vim.keymap.set(
                        { "n", "v" },
                        "<leader>hs",
                        "<CMD>Gitsigns stage_hunk<CR>",
                        { buffer = bufnr, desc = "[S]tage" }
                    )
                    vim.keymap.set(
                        { "n", "v" },
                        "<leader>hr",
                        "<CMD>Gitsigns reset_hunk<CR>",
                        { buffer = bufnr, desc = "[R]eset" }
                    )
                    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "[S]tage File" })
                    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[U]ndo" })
                    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "[R]eset File" })
                    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "[P]review" })
                    vim.keymap.set("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end, { buffer = bufnr, desc = "[B]lame line" })
                    vim.keymap.set(
                        "n",
                        "<leader>hB",
                        gs.toggle_current_line_blame,
                        { buffer = bufnr, desc = "Toggle [B]lame Line" }
                    )
                    vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "[D]iff This" })
                    vim.keymap.set("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end, { buffer = bufnr, desc = "[D]iff This ~" })
                    vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = bufnr, desc = "[T]oggle Deleted" })
                    -- Text object
                    vim.keymap.set(
                        { "o", "x" },
                        "ih",
                        "<CMD><C-U>Gitsigns select_hunk<CR>",
                        { buffer = bufnr, desc = "GitSigns Select Hunk" }
                    )
                end,
            })
        end,
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        keys = {
            { "<leader>gi", "<CMD>Git<CR>" },
            -- It allows me to easily set the branch I am pushing and any tracking
            { "<leader>gt", "<CMD>Git push -u origin <CR>" },
        },
    },
    -- Miscellaneous
    { "numToStr/Comment.nvim", config = true, event = "VeryLazy" }, -- 'gc' to comment visual regions/lines
    { "windwp/nvim-autopairs", config = true },                  -- Autopair stuff like ({["'
    {
        "kylechui/nvim-surround",                                -- Surround selections
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        version = "*",
        config = true,
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
