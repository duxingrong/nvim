return {
	-- 自动高亮当前单词
	{
		"RRethy/vim-illuminate",
		config = function()
			require('illuminate').configure({
				providers = {
					-- 'lsp',
					-- 'treesitter',
					'regex',
				},
			})
			vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
		end
	},
	-- 颜色代码的后面显示一个带颜色的小方块
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true,      -- #RGB hex codes
				RRGGBB = true,   -- #RRGGBB hex codes
				names = true,      -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = true,  -- 0xAARRGGBB hex codes
				rgb_fn = false,   -- CSS rgb() and rgba() functions
				hsl_fn = false,   -- CSS hsl() and hsla() functions
				css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
				sass = { enable = false },
				virtualtext = "■",
			},
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		}
	},
	-- key : gs ==> 布尔值，反义词快速切换
	{ 'theniceboy/antovim', lazy = false, },
	-- Enter ： 选中光标所在的括号/引号内部的内容
	{ 'gcmt/wildfire.vim',  lazy = false, },
	-- 优化折叠功能
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async", },
		config = function() require('ufo').setup() end
	},
	-- 自动补全括号
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
}
