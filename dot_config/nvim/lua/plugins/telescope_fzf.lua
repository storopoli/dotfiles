return {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
}