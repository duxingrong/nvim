local labels = "arstneiowfuydh"
return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- 插件选项 opts 和快捷键 keys 是平级的
		opts = {
			labels = labels,
			jump = {
				jumplist = true,
			},
			label = {
				uppercase = false,
				after = true,
				style = "inline",
				reuse = "all",
				distance = true,
				rainbow = {
					enabled = true,
					shade = 8,
				},
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = false, -- 保留原生的 f/F/t/T 功能
				},
				treesitter = {
					labels = labels,
					jump = { pos = "range" },
				},
			},
			prompt = {
				enabled = true,
				prefix = { { "⚡", "FlashPromptIcon" } },
			},
		},
		keys = {
			{
				"ss",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"sS",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({ search = { multi_window = true } })
				end,
				desc = "Flash Jump (All Windows)",
			},
		},
	},
}
