return {
	"markdown-tree",
	dir = vim.fn.stdpath("config") .. "/lua/markdown-tree",
	ft = "markdown",
	config = function()
		vim.api.nvim_create_user_command("MarkdownOpenPanel", require("markdown-tree").open_panel, {})
		vim.api.nvim_create_user_command("MarkdownClosePanel", require("markdown-tree").close_panel, {})
	    vim.api.nvim_create_user_command("MarkdownTogglePanel", require("markdown-tree").toggle_panel, {})
        --vim.keymap.set("n", "<C-m>", ":MarkdownTogglePanel<CR>", {})
        vim.keymap.set("n", "<leader>op", ":MarkdownTogglePanel<CR>", {})
    end,
}
