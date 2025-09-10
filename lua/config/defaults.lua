-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true

-- You can also add relative line numbers, to help with jumping.
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = true

-- 如果你希望操作系统的剪贴板保持独立，请移除此选项。
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- 启用断行缩进
vim.opt.breakindent = true

-- 保存撤销历史(即使文件关闭，下次打开还是能撤回)
vim.opt.undofile = true

-- 忽略大小写 以及智能大小写
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 始终显示标记列,即使当前文件没有标记
vim.opt.signcolumn = 'no'

-- 更新间隔时间,包括自动保存,屏幕更新,自动完成触发,语法检查或诊断工具的更新
vim.opt.updatetime = 250

--建映射序列的等待时间,即在按下一个建映射的第一个键后,nvim等待其他键的时间
vim.opt.timeoutlen = 300

-- 配置新分屏在nvim中的打开方式,垂直就右侧打开,水平就下方打开
vim.opt.splitright = true
vim.opt.splitbelow = true

--  显示空白字符的方式
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- 实时预览替换,nvim会在输入替换指令的同时,在新分屏窗口中显示替换的预览
vim.opt.inccommand = 'split'

-- 高亮当前行
vim.opt.cursorline = true

-- 光标上方和下方保留的最小屏幕行数
vim.opt.scrolloff = 10

-- 复制文本的时候高亮显示
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--启动24位色彩支持
vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

--加速终端响应
vim.o.ttyfast = true

--自动切换目录
vim.o.autochdir = true

--禁用安全模式
vim.o.secure = false

--缩进
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true

--立即响应
vim.o.ttimeoutlen = 0
vim.o.timeout = false

--保存视图时的选项
vim.o.viewoptions = 'cursor,folds,slash,unix'

--折叠和文本宽度设置
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.indentexpr = ''
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldenable = true
vim.o.foldlevelstart = 99

--格式化和分割窗口设置
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')

--设置自动补全的行为
vim.o.completeopt = 'longest,noinsert,menuone,noselect,preview'

--100列显示一条直线
vim.o.updatetime = 100



