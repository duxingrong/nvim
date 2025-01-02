vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local mode_nv = { 'n', 'v' }
local mode_v = { 'v' }
local mode_i = { 'i' }

local nmappings = {
  { from = 'S', to = ':w<CR>' },
  { from = ';', to = ':', mode = mode_nv },
  { from = 'Y', to = '"+y', mode = mode_v },
  { from = '`', to = '~', mode = mode_nv },
  --用kj代替<ESC>
  { from = 'kj', to = '<ESC>', mode = mode_i },

  --{ from = 'K', to = '7k', mode = mode_nv },
  { from = 'J', to = '7j', mode = mode_nv },
  { from = 'N', to = '0', mode = mode_nv },
  { from = 'M', to = '$', mode = mode_nv },

  --c++神器
  { from = '<c-y>', to = '<ESC>A {}<ESC>i<CR><ESC>ko', mode = mode_i },
  { from = '<leader>k', to = '<C-w>k' },
  { from = '<leader>j', to = '<C-w>j' },
  { from = '<leader>h', to = '<C-w>h' },
  { from = '<leader>l', to = '<C-w>l' },
  { from = 'qf', to = '<C-w>o' },
  { from = 's', to = '<nop>' },
  { from = 'sk', to = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>', desc = 'Move focus to the upper window' },
  { from = 'sj', to = ':set splitbelow<CR>:split<CR>', desc = 'Move focus to the lower window' },
  { from = 'sh', to = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', desc = 'Move focus to the left window' },
  { from = 'sl', to = ':set splitright<CR>:vsplit<CR>', desc = 'Move focus to the right window' },

  { from = '<up>', to = ':res +5<CR>' },
  { from = '<down>', to = ':res -5<CR>' },
  { from = '<left>', to = ':vertical resize-5<CR>' },
  { from = '<right>', to = ':vertical resize+5<CR>' },

  -- Tab management
  { from = 'tu', to = ':tabe<CR>' },
  { from = 'tU', to = ':tab split<CR>' },
  { from = 'th', to = ':-tabnext<CR>' },
  { from = 'tl', to = ':+tabnext<CR>' },
  { from = 'tmh', to = ':-tabmove<CR>' },
  { from = 'tml', to = ':+tabmove<CR>' },

  -- Other
  { from = '<leader>sw', to = ':set wrap<CR>' }, --开启自动换行
  { from = '<leader>sc', to = ':set spell!<CR>' }, --检查拼写错误
  { from = '<leader><CR>', to = ':nohlsearch<CR>' }, --取消语法高亮
  { from = '<f10>', to = ':TSHighlightCapturesUnderCursor<CR>' }, --用于显示光标下的语法捕获组
  { from = '<leader>o', to = 'za' }, --折叠函数
  { from = '<leader>pr', to = ':profile start profile.log<CR>:profile func *<CR>:profile file *<CR>' }, --nvim的性能分析
  { from = '<leader><esc>', to = '<nop>' },
  { from = 'q', to = '<nop>' },
  { from = 'KJ', to = [[<C-\><C-n>]], desc = 'Exit terminal mode' },
  { from = '<', to = '<gv', mode_v },
  { from = '>', to = '<gv', mode_v },
  { from = '<', to = '<<' },
  { from = '>', to = '>>' },
}

--循环设置案件映射
for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to, { desc = mapping.desc })
end

------------------------------------------------------自写插件------------------------------------------------------------------------------------
--脚本
require 'scripts.compile_run'
require 'scripts.wiki'
require 'scripts.ctrlu'
require 'scripts.image'
require 'scripts.vertical_cursor_movement'
--markdown
local wiki = require 'scripts.wiki'
vim.keymap.set('n', '<leader>ww', wiki.open_wiki, { noremap = true, silent = true })
local image = require 'scripts.image'
vim.keymap.set('n', '<leader>p', image.paste, { noremap = true, silent = true })
-- 创建一个自动命令组
vim.api.nvim_create_augroup('IndexMarkdown', { clear = true })
-- 定义自动命令
vim.api.nvim_create_autocmd('BufReadPost', {
  group = 'IndexMarkdown',
  pattern = 'index.md',
  callback = function()
    -- 设置仅在当前缓冲区有效的快捷键映射
    vim.keymap.set('n', '<CR>', require('scripts.wiki').open_create, { buffer = true, noremap = true, silent = true })
    vim.keymap.set('v', '<CR>', require('scripts.wiki').open_create, { buffer = true, noremap = true, silent = true })
  end,
})

vim.keymap.set('n', 'Q', function()
  local buffers = vim.fn.getbufinfo { buflisted = 1 } -- 获取当前所有已列出的缓冲区
  if #buffers > 1 then -- 如果有多个缓冲区，执行 bdelete 关闭当前缓冲区
    vim.cmd 'bdelete'
  else -- 否则执行 :q 退出
    vim.cmd 'q'
  end
end, { noremap = true, silent = true, desc = 'Close buffer or quit Vim' })

--诊断
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- 绑定 <leader>d 切换浮动诊断消息的显示/隐藏
vim.keymap.set('n', '<leader>d', function()
  local diagnostics = vim.diagnostic.get(0) -- 获取当前缓冲区的诊断信息
  if #diagnostics > 0 then
    vim.diagnostic.hide() -- 如果有诊断信息，隐藏它
  else
    vim.diagnostic.show() -- 如果没有诊断信息，显示它
  end
end, { desc = 'Toggle floating diagnostic message' })
