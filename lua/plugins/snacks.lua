return {                 -- 返回一个包含插件规范的表，这是 lazy.nvim 管理插件的标准方式
	{
		'folke/snacks.nvim', -- 插件的名称或 GitHub shorthand (user/repo)
		priority = 1000,     -- 设置插件加载的优先级，数值越大优先级越高 (1000 表示非常高)
		lazy = false,        -- 设置为 false 表示 Neovim 启动时立即加载此插件，而不是延迟加载
		---@type snacks.Config -- LuaLS 类型标注：声明 opts 表的类型是 snacks.Config (用于类型检查和补全)
		opts = {             -- 传递给插件的配置选项表
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			-- (以上为插件作者的注释，提示用户在此处进行配置或参考文档)

			bigfile = { enabled = true },                                               -- 启用大文件优化处理功能
			explorer = { enabled = false },                                             -- 禁用 snacks 内置的文件浏览器 (可能用户使用其他文件浏览器插件)
			image = {                                                                   -- 图片预览相关设置
				enabled = true,                                                           -- 启用图片预览功能
				doc = { inline = false, float = false, max_width = 80, max_height = 40 }, -- 文档中图片预览的设置 (此处均未激活内联或浮动)
				math = { latex = { font_size = 'small' } },                               -- 数学公式 (LaTeX) 预览的字体大小
			},
			indent = {                                                                  -- 缩进和范围高亮相关设置
				enabled = true,                                                           -- 启用缩进指示和范围高亮
				animate = {                                                               -- 缩进动画效果
					enabled = false,                                                        -- 禁用缩进动画
				},
				indent = {                                                                -- 缩进线本身的行为
					only_scope = true,                                                      -- 缩进线可能只在当前主要作用域显示 (具体行为需查阅插件文档)
				},
				scope = {                                                                 -- 当前作用域高亮
					enabled = true,                                                         -- 启用高亮当前代码作用域
					underline = true,                                                       -- 给作用域的起始位置添加下划线
				},
				chunk = {                                                                 -- 代码块渲染方式
					-- when enabled, scopes will be rendered as chunks, except for the top-level scope which will be rendered as a scope.
					-- (插件作者注释：启用时，作用域将渲染为代码块，顶层作用域除外)
					enabled = true, -- 启用将作用域渲染为代码块的功能
				},
			},
			input = { enabled = true },     -- 启用增强的输入框/浮动窗口输入功能
			lazygit = {                     -- Lazygit 集成设置
				enabled = true,               -- 启用 Lazygit 集成
				configure = false,            -- snacks.nvim 是否应自动配置 lazygit (false 表示用户可能自行配置或使用默认)
			},
			quickfile = { enabled = true }, -- 启用快速文件操作/导航功能
			scroll = { enabled = false },   -- 禁用 snacks 提供的滚动条或滚动动画功能 (与 indent.animate 不同)
			-- Create keymappings of `ii` and `ai` for textobjects, and `[i` and `]i` for jumps
			scope = {                       -- 与 `indent.scope` 可能相关或扩展的范围设置
				enabled = true,               -- 启用基于范围的文本对象和跳转
				cursor = false,               -- 是否在光标处也显示范围指示 (false 表示不显示)
			},

			statuscolumn = { enabled = true }, -- 启用 snacks 对状态列的增强或自定义
			words = { enabled = true },        -- 启用与单词相关的功能 (如高亮当前单词的引用)
			styles = {                         -- 不同 UI 组件的样式定义
				terminal = {                     -- 浮动终端的样式
					relative = 'editor',           -- 相对于编辑器定位
					border = 'rounded',            -- 圆角边框
					position = 'float',            -- 浮动窗口形式
					backdrop = 60,                 -- 背景模糊/暗化程度 (0-100)
					height = 0.9,                  -- 高度为编辑器高度的90%
					width = 0.9,                   -- 宽度为编辑器宽度的90%
					zindex = 50,                   -- 窗口堆叠顺序
				},
			},
		},

		keys = {                              -- 定义 snacks 相关的快捷键 (这是 lazy.nvim 的标准快捷键定义方式)
			{
				'<leader>si',                     -- 快捷键：<Leader>si (通常 Leader 是 '\' 或 ' ')
				function()
					require('snacks').image.hover() -- 功能：显示光标下（或指定）图片的预览
				end,
				desc = '[Snacks] Display image',  -- 快捷键描述
			},
			-- Notification (通知相关快捷键)
			{
				'<leader>,',                         -- 快捷键：<Leader>,
				function()
					require('snacks').picker.buffers() -- 功能：打开缓冲区列表选择器
				end,
				desc = '[Snacks] Buffers',           -- 快捷键描述
			},
			-- git (Git 相关快捷键)
			{
				'<C-g>',                      -- 快捷键：Ctrl-g
				function()
					require('snacks').lazygit() -- 功能：打开 Lazygit 界面
				end,
				desc = '[Snacks] Lazygit',
			},
			{
				'<leader>gl',                        -- 快捷键：<Leader>gl
				function()
					require('snacks').picker.git_log() -- 功能：打开 Git 提交历史 (log) 选择器
				end,
				desc = '[Snacks] Git log',
			},
			{
				'<leader>gd',                         -- 快捷键：<Leader>gd
				function()
					require('snacks').picker.git_diff() -- 功能：打开 Git diff 选择器 (查看更改)
				end,
				desc = '[Snacks] Git diff',
			},
			{
				'<leader>gb',                        -- 快捷键：<Leader>gb
				function()
					require('snacks').git.blame_line() -- 功能：显示当前行的 Git blame 信息
				end,
				desc = '[Snacks] Git blame line',
			},
			{
				'<leader>gB',                   -- 快捷键：<Leader>gB
				function()
					require('snacks').gitbrowse() -- 功能：在浏览器中打开当前文件或项目的 Git 仓库页面
				end,
				desc = '[Snacks] Git browse',
			},
			{
				'<leader>sg',                     -- 快捷键：<Leader>sg
				function()
					require('snacks').picker.grep() -- 功能：打开文本内容搜索 (grep) 选择器
				end,
				desc = '[Snacks] Grep',
			},
			-- LSP (LSP 相关跳转的选择器)
			{
				'gd',                                        -- 快捷键：gd (通常是 LSP 的 Goto Definition)
				function()
					require('snacks').picker.lsp_definitions() -- 功能：使用 snacks 选择器进行 LSP Goto Definition
				end,
				desc = '[Snacks] Goto definition',
			},
			{
				'gD',                                         -- 快捷键：gD (通常是 LSP 的 Goto Declaration)
				function()
					require('snacks').picker.lsp_declarations() -- 功能：使用 snacks 选择器进行 LSP Goto Declaration
				end,
				desc = '[Snacks] Goto declaration',
			},
			{
				'gr',                                       -- 快捷键：gr (通常是 LSP 的 Goto References)
				function()
					require('snacks').picker.lsp_references() -- 功能：使用 snacks 选择器进行 LSP Goto References
				end,
				desc = '[Snacks] References',
			},
			{
				'gI',                                            -- 快捷键：gI (通常是 LSP 的 Goto Implementation)
				function()
					require('snacks').picker.lsp_implementations() -- 功能：使用 snacks 选择器进行 LSP Goto Implementation
				end,
				desc = '[Snacks] Goto implementation',
			},
			{
				'gy',                                             -- 快捷键：gy (通常是 LSP 的 Goto Type Definition)
				function()
					require('snacks').picker.lsp_type_definitions() -- 功能：使用 snacks 选择器进行 LSP Goto Type Definition
				end,
				desc = '[Snacks] Goto t[y]pe definition',
			},
			-- Zen mode (禅模式/专注模式)
			{
				'zz',                     -- 快捷键：<Leader>z
				function()
					require('snacks').zen() -- 功能：切换禅模式
				end,
				desc = '[Snacks] Toggle Zen Mode',
			},
		},

		init = function()                       -- 插件加载时执行的初始化函数 (由于 lazy=false, 这会在启动时较早运行)
			local Snacks = require 'snacks'       -- 加载 snacks 模块
			vim.api.nvim_create_autocmd('User', { -- 创建一个自动命令
				pattern = 'VeryLazy',               -- 监听 lazy.nvim 的 'VeryLazy' 事件 (当所有延迟加载插件加载完毕后触发)
				callback = function()               -- 事件触发时执行的回调函数
					-- Setup some globals for debugging (lazy-loaded)
					-- (插件作者注释：为调试设置一些全局函数，它们是延迟加载的)
					_G.dd = function(...)       -- 定义全局函数 dd (dump and die / debug dump)
						Snacks.debug.inspect(...) -- 使用 snacks 的 inspect 功能来打印和检查变量
					end
					_G.bt = function()          -- 定义全局函数 bt (backtrace)
						Snacks.debug.backtrace()  -- 使用 snacks 显示当前的调用堆栈
					end
					vim.print = _G.dd           -- 重写 Neovim 内置的 vim.print，使其使用 dd (这意味着在命令行使用 := 会调用 snacks.debug.inspect)

					-- 自定义 snacks 选择器列表光标行的高亮颜色
					vim.api.nvim_set_hl(0, 'SnacksPickerListCursorLine', { bg = '#313244' }) -- 设置背景色
				end,
			})
		end,
	},
}
