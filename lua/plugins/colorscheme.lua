return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		opts = {
			transparent_background = true,
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.surface2 },
					Visual = { bg = colors.overlay0 },
					Search = { bg = colors.surface2 },
					IncSearch = { bg = colors.lavender },
					CurSearch = { bg = colors.lavender },
					MatchParen = { bg = colors.lavender, fg = colors.base, bold = true },
				}
			end,
			integrations = {
				barbar = true,
				blink_cmp = true,
				gitsigns = true,
				mason = true,
				noice = true,
				notify = true,
				nvimtree = true,
				rainbow_delimiters = true,
				snacks = {
					enabled = true,
					indent_scope_color = 'flamingo', -- catppuccin color (eg. `lavender`) Default: text
				},
				which_key = true,
			},
		},
		config = function(_, opts)
			-- 自定义 Startify 的颜色，适配 nvim-deus 主题
			vim.cmd [[
		    highlight StartifyHeader guifg=#d8a657 guibg=NONE ctermfg=Yellow ctermbg=NONE
		    highlight StartifyBracket guifg=#e7c547 guibg=NONE ctermfg=Yellow ctermbg=NONE
		    highlight StartifyNumber guifg=#8ec07c guibg=NONE ctermfg=Green ctermbg=NONE
		    highlight StartifyFile guifg=#d8a657 guibg=NONE ctermfg=Yellow ctermbg=NONE
		    highlight StartifyFooter guifg=#b16286 guibg=NONE ctermfg=Magenta ctermbg=NONE

		    " 将目录的颜色改为粉红色
		    highlight StartifyPath guifg=#ff79c6 guibg=NONE ctermfg=Magenta ctermbg=NONE
		  ]]
			require('catppuccin').setup(opts)
			vim.cmd.colorscheme 'catppuccin'
		end,
	},
}
