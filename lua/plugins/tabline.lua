return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons", -- 依赖图标插件，为了显示文件图标
	opts = {
		options = {
			-- 【重要】模式设置
			-- "buffers": (默认) 显示所有打开的文件 buffer。像 VS Code 一样。
			-- "tabs":    只显示 Vim 的原生 Tab (标签页)。这意味着你 :e 打开新文件时上方不会多一个标签，
			--            只有当你用 :tabnew 打开新标签页时才会增加。
			mode = "tabs",

			-- 集成 LSP 诊断
			-- 当你的代码有错误或警告时，会在标签上显示出来
			diagnostics = "nvim_lsp",

			-- 自定义诊断信息的显示方式
			-- count: 错误数量, level: 错误等级(error/warning)
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				-- 如果是 error 级别，显示  图标，否则显示  (警告)
				local icon = level:match("error") and " " or " "
				-- 返回格式：空格 + 图标 + 数量 (例如: "  3")
				return " " .. icon .. count
			end,

			-- 指示器配置 (当前激活标签页左侧那个小竖条)
			indicator = {
				icon = "▎", -- 指示器的图标字符
				style = "icon", -- 样式设置为图标 (也可以是 'underline' 下划线)
			},

			-- 是否在每个标签上显示关闭按钮 'x' (这里设为 false 不显示)
			-- 你可以通过鼠标中键点击来关闭，或者用快捷键
			show_buffer_close_icons = false,

			-- 是否在最右侧显示一个总的关闭按钮 (这里设为 false 不显示)
			show_close_icon = false,

			-- 强制标签页宽度一致 (看起来更整齐，不会因为文件名长短不一而乱)
			enforce_regular_tabs = true,

			-- 如果有重复文件名的文件，是否显示前缀来区分 (false 表示不显示)
			show_duplicate_prefix = false,

			-- 标签页的标准宽度
			tab_size = 16,

			-- 标签页内部的内边距
			padding = 0,

			-- 分割线样式
			-- 可选: "slant" (倾斜, 像浏览器的标签), "thick" (厚实), "thin" (细线), "slope"
			-- "thick" 会让标签看起来比较方正且边界分明
			separator_style = "slant",
		},
	},
}
