-- lua/core/options.lua

local opt = vim.opt -- 引用 vim.opt

-- Leader 键 (再次确认)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 编码
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- 行号
opt.number = true       -- 显示行号
opt.relativenumber = true -- 显示相对行号

-- 缩进
opt.tabstop = 4         -- Tab 宽度为 4 个空格
opt.shiftwidth = 4      -- 自动缩进宽度为 4 个空格
opt.expandtab = true    -- 使用空格代替 Tab
opt.autoindent = true   -- 自动缩进
opt.smartindent = true  -- 智能缩进

-- 界面
opt.termguicolors = true -- 启用 True Color 支持
opt.signcolumn = 'yes'   -- 始终显示符号列 (用于 LSP 提示、Git Gutter 等)
opt.wrap = false         -- 不自动换行
opt.scrolloff = 8        -- 光标上下保留 8 行距离
opt.sidescrolloff = 8    -- 光标左右保留 8 列距离
opt.cursorline = true    -- 高亮当前行

-- 搜索
opt.ignorecase = true   -- 搜索时忽略大小写
opt.smartcase = true    -- 如果搜索词包含大写字母，则不忽略大小写
opt.hlsearch = true     -- 高亮搜索结果
opt.incsearch = true    -- 输入搜索词时实时预览结果

-- 性能
opt.updatetime = 250    -- 更新 Lsp/GitGutter 等的延迟时间 (毫秒)
opt.timeoutlen = 300    -- 等待映射输入的超时时间 (毫秒)

-- 备份与交换文件
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- 剪贴板 (Windows 通常默认支持)
opt.clipboard = 'unnamedplus' -- 与系统剪贴板共享 (需要 +clipboard 或 *clipboard 支持)

-- 其他
opt.completeopt = {'menu', 'menuone', 'noselect'} -- 补全选项
opt.hidden = true        -- 允许在不保存的情况下切换缓冲区
opt.mouse = 'a'          -- 启用所有模式下的鼠标支持
opt.splitright = true    -- 垂直分割时新窗口出现在右侧
opt.splitbelow = true    -- 水平分割时新窗口出现在下方

-- print("Core options loaded.")