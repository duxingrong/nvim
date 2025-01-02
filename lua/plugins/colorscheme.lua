return {
	'theniceboy/nvim-deus',
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd [[colorscheme deus]]

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
	end,
}
