return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        --require'alpha'.setup(require'alpha.themes.theta'.config)
        local alpha = require("alpha")
        local theta = require("alpha.themes.theta")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        theta.header.val = {
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        }

        -- Set menu
        theta.buttons.val = {
            { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
            { type = "padding", val = 1 },
            dashboard.button("e", "  New file", "<cmd>ene<CR>"),
            dashboard.button("SPC f f", "󰈞  Find file"),
            dashboard.button("SPC f g", "󰊄  Live grep"),
            --dashboard.button("c", "  Configuration", "<cmd>cd stdpath('.config')<CR>"),
            dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim<CR>"),
            dashboard.button("p", "  Plugins configuration", "<cmd>Lazy<CR>"),
            dashboard.button("m", "  Mason configuration", "<cmd>Mason<CR>"),
            dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
        }

        alpha.setup(theta.config)
    end,
}
