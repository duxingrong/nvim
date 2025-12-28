return {
	-- 插件名称
	"iamcco/markdown-preview.nvim",
	-- 仅在打开 markdown 文件时加载
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },

	-- 【重要】安装后需要构建。如果这一步失败（比如没装 yarn），见下文手动解决
	build = "cd app && npm install",

	-- 配置部分 (注意：这个插件比较特殊，它的配置要写在 init 里，使用 vim.g 全局变量)
	init = function()
		-- 设置浏览器打开时的标题
		vim.g.mkdp_page_title = "「${name}」"

		-- 允许使用的文件类型
		vim.g.mkdp_filetypes = { "markdown" }

		-- 下面这几个选项根据喜好开启/关闭：

		-- 1. 切换 buffer 时是否自动关闭预览窗口 (1=自动关闭, 0=不关闭)
		-- 建议设为 0，否则你切去看别的代码，浏览器窗口就没了
		vim.g.mkdp_auto_close = 0

		-- 2. 打开 markdown 文件时是否自动开启预览 (1=是, 0=否)
		-- 建议设为 0，需要时再手动开启
		vim.g.mkdp_auto_start = 1

		-- 3. 指定浏览器 (默认会自动寻找系统默认浏览器)
		-- 如果无法自动打开，可以取消注释并修改为你浏览器的路径
		-- vim.g.mkdp_browser = 'google-chrome-stable'
	end,

	-- 快捷键绑定 (可选)
	keys = {
		{
			"r",
			"<cmd>MarkdownPreviewToggle<cr>",
			desc = "Markdown Preview Toggle",
			ft = "markdown",
		},
	},
}
