return {
	{
		"kevinhwang91/nvim-hlslens",
		lazy = false,
		enabled = true,
		keys = {
			{
				"=",
				[[<cmd>execute('normal! ' . v:count1 . 'n')<cr>]] .. [[<cmd>lua require("hlslens").start()<cr>]],
			},
			{
				"-",
				[[<cmd>execute('normal! ' . v:count1 . 'N')<cr>]] .. [[<cmd>lua require("hlslens").start()<cr>]],
			},
			{ "*",  "*" .. [[<cmd>lua require("hlslens").start()<cr>]] },
			{ "#",  "#" .. [[<cmd>lua require("hlslens").start()<cr>]] },
			{ "g*", "g*" .. [[<cmd>lua require("hlslens").start()<cr>]] },
			{ "g#", "g#" .. [[<cmd>lua require("hlslens").start()<cr>]] },
		},
		config = function()
			require("scrollbar.handlers.search").setup()
		end
	},

	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>F",
				mode = "n",
				function()
					vim.cmd(":GrugFar")
				end,
				desc = "Project find and replace"
			}
		},
		config = function()
			require('grug-far').setup({});
		end
	},
}
