return {
	{
		"Saghen/blink.cmp",
		build = "cargo build --release",
		version = "v0.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",

		-- 【关键修改在这里】
		-- init 函数会在插件加载前运行，我们在这里设置颜色
		init = function()
			-- 这里的颜色代码主要参考了你之前提供的配置，保持风格一致
			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰊄",
			}

			-- 定义颜色 (参考你旧配置的配色)
			local kind_colors = {
				-- 蓝色系：方法、属性、接口
				Method = "#6C8ED4",
				Value = "#6C8ED4",
				EnumMember = "#6C8ED4",

				-- 紫色系：函数、类、结构体
				Function = "#A377BF",
				Struct = "#A377BF",
				Class = "#A377BF",
				Module = "#A377BF",
				Operator = "#A377BF",

				-- 黄色/橙色系：常量、构造器、引用
				Constant = "#D4BB6C",
				Constructor = "#D4BB6C",
				Reference = "#D4BB6C",
				Snippet = "#D4A959",
				Folder = "#D4A959",
				Unit = "#D4A959",

				-- 绿色系：关键字、文本
				Keyword = "#9FBD73",
				Text = "#9FBD73",
				Enum = "#9FBD73",

				-- 红色/深色系：变量、字段
				Variable = "#CCCCCC", -- 变量通常用亮白或浅灰
				Field = "#B5585F",
				Property = "#B5585F",
				Event = "#B5585F",

				-- 其他
				File = "#7E8294",
				Interface = "#58B5A8",
				Color = "#58B5A8",
				TypeParameter = "#58B5A8",
			}

			-- 将颜色应用到 BlinkCmpKind... 高亮组
			-- Blink 默认使用 "BlinkCmpKind" + 类型名 作为高亮组名
			for kind, color in pairs(kind_colors) do
				vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { fg = color, default = true })
			end
		end,

		opts = {
			appearance = {
				-- 设置为 true，告诉 blink 使用 Nerd Font 图标
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "snippets", "lsp", "path", "buffer" },
			},

			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },

				-- 这里配置列表的显示
				menu = {
					border = "rounded",
					draw = {
						-- 定义列：图标 | 文字+描述 | 类型名
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
					},
				},
			},

			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
