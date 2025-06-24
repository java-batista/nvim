return {
    "markdown-tree",
    dir = vim.fn.stdpath("config") .. "/lua/markdown-tree",
    ft = "markdown",
    config = function()
        vim.api.nvim_create_user_command("MarkdownOpenPanel", require("markdown-tree").open_panel, {})
        vim.api.nvim_create_user_command("MarkdownClosePanel", require("markdown-tree").close_panel, {})
    end,
}
