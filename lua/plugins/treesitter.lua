return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 1000,
		build = ":TSUpdate",

		config = function()
			-- 关闭 Vim 原生的智能缩进
			vim.opt.smartindent = false

			require("nvim-treesitter.configs").setup({
				-- 自动安装缺失的解析器
				auto_install = true,

				-- 同步安装设为 false 避免卡顿
				sync_install = false,

				-- 确保安装的语言列表
				ensure_installed = {
					"markdown",
					"html",
					"javascript",
					"typescript",
					"tsx",
					"query",
					"dart",
					"java",
					"c",
					"prisma",
					"bash",
					"go",
					"lua",
					"kdl",
					"vim",
					"terraform",
					"dockerfile",
					"yaml",
					"python",
					"luadoc",
					"vimdoc", -- 建议加上这两个，用于 vim 帮助文档高亮
				},

				-- 模块 1：语法高亮
				highlight = {
					enable = true,
					disable = {},
					-- 某些大文件可能会卡顿，可以开启这个选项（可选）
					additional_vim_regex_highlighting = false,
				},

				-- 模块 2：缩进
				indent = {
					enable = true,
					disable = function(lang, bufnr)
						local disallowed_filetypes = { "yaml" }
						return vim.tbl_contains(disallowed_filetypes, lang)
					end,
				},

				-- 模块 3：增量选择
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-n>",
						node_incremental = "<c-n>",
						node_decremental = "<c-h>",
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local tscontext = require("treesitter-context")
			tscontext.setup({
				enable = true,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})

			vim.keymap.set("n", "[c", function()
				tscontext.go_to_context()
			end, { silent = true })
		end,
	},
}
