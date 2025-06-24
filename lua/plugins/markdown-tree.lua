return {
    "markdown-tree",
    dir = vim.fn.stdpath("config") .. "/lua/markdown-tree",
    ft = "markdown",
    config = function()
        vim.api.nvim_create_user_command("MarkdownHeadingsPanel", require("markdown-tree").open_panel, {})
    end,
}
