-- lua/core/keymaps.lua
local keymap = vim.keymap.set
local map_opts = { noremap = true, silent = true } -- 默认映射选项

local mode_n = { 'n' }      -- Normal mode
local mode_v = { 'v' }      -- Visual mode
local mode_nv = { 'n', 'v' } -- Normal and Visual mode
local mode_i = { 'i' }      -- Insert mode
local mode_t = { 't' }      -- Terminal mode

-- print("Setting custom keymaps...")

-- 基本操作
keymap(mode_n, 'S', ':w<CR>', { noremap = true, silent = false, desc = 'Save file' }) -- 保存文件 (允许显示消息)
keymap(mode_nv, ';', ':', { noremap = true, desc = 'Enter command mode' })
keymap(mode_v, 'Y', '"+y', { noremap = true, desc = 'Yank to system clipboard' })
keymap(mode_nv, '`', '~', { noremap = true, desc = 'Swap case' })

-- Insert 模式下的 ESC 替代
keymap(mode_i, 'kj', '<ESC>', map_opts)

-- 快速移动
keymap(mode_nv, 'K', '7k', map_opts)
keymap(mode_nv, 'J', '7j', map_opts)
keymap(mode_nv, 'N', '0', map_opts)
keymap(mode_nv, 'M', '$', map_opts)

-- C++ 神器
keymap(mode_i, '<c-y>', '<ESC>A {}<ESC>i<CR><ESC>ko<ESC>O', { noremap = true, silent = true, desc = 'Insert C++ block' }) -- 稍微调整了最后进入 O 模式以便更好对齐

-- 窗口导航 (Leader + HJKL)
keymap(mode_n, '<leader>k', '<C-w>k', { desc = 'Move focus to upper window' })
keymap(mode_n, '<leader>j', '<C-w>j', { desc = 'Move focus to lower window' })
keymap(mode_n, '<leader>h', '<C-w>h', { desc = 'Move focus to left window' })
keymap(mode_n, '<leader>l', '<C-w>l', { desc = 'Move focus to right window' })

-- 窗口分割 (你的 s + 方向键映射)
keymap(mode_n, 's', '<nop>', map_opts) -- 禁用 s
keymap(mode_n, 'sk', ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>', { desc = 'Split window above' })
keymap(mode_n, 'sj', ':set splitbelow<CR>:split<CR>', { desc = 'Split window below' })
keymap(mode_n, 'sh', ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', { desc = 'Split window left' })
keymap(mode_n, 'sl', ':set splitright<CR>:vsplit<CR>', { desc = 'Split window right' })

-- 窗口大小调整 (方向键)
keymap(mode_n, '<up>', ':resize +5<CR>', { desc = 'Increase window height' })
keymap(mode_n, '<down>', ':resize -5<CR>', { desc = 'Decrease window height' })
keymap(mode_n, '<left>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
keymap(mode_n, '<right>', ':vertical resize +5<CR>', { desc = 'Increase window width' })

-- 其他实用映射
keymap(mode_n, '<leader>sc', ':set spell!<CR>', { desc = 'Toggle spell check' })
keymap(mode_n, '<leader><CR>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })
keymap(mode_n, '<leader>z', 'za', { desc = 'Toggle fold' })

-- 禁用 q (宏录制)
keymap(mode_n, 'q', '<nop>', map_opts)

-- Visual 模式下的缩进后重新选择
keymap(mode_v, '<', '<gv', map_opts)
keymap(mode_v, '>', '>gv', map_opts)

-- Normal 模式下的缩进 (保持默认行为，如果需要可以重写，但通常不需要)
-- keymap(mode_n, '<', '<<', map_opts) -- 已存在
-- keymap(mode_n, '>', '>>', map_opts) -- 已存在

-- Terminal 模式退出 (用你的 KJ)
keymap(mode_t, 'KJ', [[<C-\><C-n>]], { noremap = true, silent = true, desc = 'Exit terminal mode' })

-- print("Custom keymaps loaded.")


vim.keymap.set('n', 'Q', function()
  local buffers = vim.fn.getbufinfo { buflisted = 1 } -- 获取当前所有已列出的缓冲区
  if #buffers > 1 then -- 如果有多个缓冲区，执行 bdelete 关闭当前缓冲区
    vim.cmd 'bdelete!'
  else -- 否则执行 :q 退出
    vim.cmd 'q'
  end
end, { noremap = true, silent = true, desc = 'Close buffer or quit Vim' })