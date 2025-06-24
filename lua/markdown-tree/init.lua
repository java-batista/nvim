-- Initialize the plugin with your custom configuration
local ts = vim.treesitter

local M = {}

-- Store heading list and original buffer
M.headings = {}
M.source_buf = nil

-- Parse headings
function M.parse_headings()
	local bufnr = vim.api.nvim_get_current_buf()
	M.source_buf = bufnr
	local lang = ts.language.get_lang(vim.bo[bufnr].filetype)
	local parser = ts.get_parser(bufnr, lang)
	local tree = parser:parse()[1]
	local root = tree:root()

	local query = ts.query.parse(
		lang,
		[[
    (atx_heading [
      (atx_h1_marker)
      (atx_h2_marker)
      (atx_h3_marker)
      (atx_h4_marker)
      (atx_h5_marker)
      (atx_h6_marker)
    ] @marker
    (inline) @content)
  ]]
	)

	local headings = {}
	local current = {}

	for id, node in query:iter_captures(root, bufnr, 0, -1) do
		local name = query.captures[id]
		if name == "marker" then
			local level = vim.treesitter.get_node_text(node, bufnr)
			table.insert(current, { level = #level, text = "", line = node:range() })
		elseif name == "content" then
			local text = vim.treesitter.get_node_text(node, bufnr)
			current[#current].text = text
		end
	end

	-- Extract line number and clean structure
	headings = vim.tbl_map(function(h)
		return {
			level = h.level,
			text = h.text,
			line = h.line + 1, -- zero-based to 1-based
		}
	end, current)

	M.headings = headings
end

-- Close side panel
function M.close_panel()
	-- Close existing if open
	if M.panel_win and vim.api.nvim_win_is_valid(M.panel_win) then
		vim.api.nvim_win_close(M.panel_win, true)
	    vim.api.nvim_win_close(M.right_panel, true)

        -- Restore default fillchars appearance
        vim.opt.fillchars = {}
        vim.opt.fillchars:append({ eob = " " })
        vim.api.nvim_set_hl(0, 'LineNr', { fg = "#808080"})

    end
end

-- Open side panel
function M.open_panel()
	-- Close existing if open
	if M.panel_win and vim.api.nvim_win_is_valid(M.panel_win) then
		vim.api.nvim_win_close(M.panel_win, true)
	    vim.api.nvim_win_close(M.right_panel, true)
    end

    vim.opt.fillchars:append({ vert = " " })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = "#181818"})

	-- Parse fresh
	M.parse_headings()

	-- Create vertical split on right
    local main_win = vim.api.nvim_get_current_win()
    vim.o.splitright = true
	vim.cmd("vsplit | vertical resize 5")
	local right_win = vim.api.nvim_get_current_win()
	local right_buf = vim.api.nvim_create_buf(false, true) -- scratch buffer
	--vim.api.nvim_buf_set_name(right_buf, 'rightpad')
    vim.api.nvim_win_set_buf(right_win, right_buf)
    vim.api.nvim_buf_set_option(right_buf, "modifiable", false)
    vim.api.nvim_set_current_win(main_win)
    M.right_panel = right_win

	-- Create vertical split on left
    vim.o.splitright = false
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true) -- scratch buffer
	vim.api.nvim_win_set_buf(win, buf)

	-- Set window options like nvim-tree
	vim.api.nvim_win_set_width(win, 30)
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "modifiable", true)

	-- Populate content
	local lines = {}
	for _, h in ipairs(M.headings) do
		local indent = string.rep("  ", h.level - 1)
		table.insert(lines, indent .. h.text)
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)

	-- Setup keymaps
	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"<CR>",
		":lua require'markdown-tree'.jump_to_heading()<CR>",
		{ noremap = true, silent = true }
	)

	-- Remember panel win
	M.panel_win = win
	M.panel_buf = buf
end

-- Jump to heading under cursor
function M.jump_to_heading()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1]
	local heading = M.headings[line]
	if heading then
		-- Jump in source buffer
		vim.api.nvim_set_current_win(vim.fn.bufwinid(M.source_buf))
		vim.api.nvim_win_set_cursor(0, { heading.line, 0 })
	end
end

return M
