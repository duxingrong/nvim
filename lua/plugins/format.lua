return {
	-- 1. 这是一个辅助插件，用来让 Mason 自动安装 "非 LSP" 的工具
	-- (Mason 默认只自动安装 LSP，formatter 需要这个插件帮忙)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("mason-tool-installer").setup({
				--在这里写下你希望 Mason 自动帮你下载的格式化工具
				ensure_installed = {
					"stylua", -- Lua 格式化神器
					"isort", -- Python 导包排序
					"black", -- Python 代码格式化 (最流行)
					"clang-format", -- C/C++ 格式化
				},
			})
		end,
	},

	-- 2. 核心格式化插件 Conform
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				-- 定义每种语言使用什么工具
				formatters_by_ft = {
					-- Lua 使用 stylua
					lua = { "stylua" },

					-- Python: 先运行 isort 整理 import，再运行 black 格式化代码
					python = { "isort", "black" },

					-- C++: 使用 clang-format
					-- 注意：因为我们在 LSP 配置里装了 clangd，其实 clangd 也自带格式化。
					-- 但用 clang-format 命令行工具通常更稳定，且支持 .clang-format 配置文件
					cpp = { "clang-format" },
					c = { "clang-format" },

					-- 兜底：对于没有专门设置的语言，尝试用 LSP 格式化
					-- "_", 这个下划线代表 "所有其他文件类型"
					-- ["_"] = { "trim_whitespace" },
				},

				-- 【保存时自动格式化设置】
				format_on_save = {
					-- 这里的 lsp_fallback = true 非常重要
					-- 意思是：如果上面 formatters_by_ft 没配置这个语言的工具，
					-- 那么就尝试请求 LSP (比如 clangd) 帮忙格式化。
					lsp_fallback = true,
					async = false, -- 同步格式化，保证保存前格式化完成
					timeout_ms = 1000, -- 1秒超时，大文件也不会卡死
				},
			})

			-- 3. 设置快捷键 (可选，手动格式化)
			-- 即使开启了自动保存，有时候也想手动按一下 <leader>f
			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range" })
		end,
	},
}
