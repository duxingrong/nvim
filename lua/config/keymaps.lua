vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local mode_nv = { 'n', 'v' }
local mode_v = { 'v' }
local mode_i = { 'i' }
local mode_t = { 't' }

local nmappings = {
  { from = 'S',             to = ':w<CR>' },
  { from = ';',             to = ':',                                                                   mode = mode_nv },
  { from = 'Y',             to = '"+y',                                                                 mode = mode_v },
  { from = '`',             to = '~',                                                                   mode = mode_nv },
  --用kj代替<ESC>
  { from = 'kj',            to = '<ESC>',                                                               mode = mode_i },

  { from = 'K',             to = '7k',                                                                  mode = mode_nv },
  { from = 'J',             to = '7j',                                                                  mode = mode_nv },
  { from = 'N',             to = '0',                                                                   mode = mode_nv },
  { from = 'M',             to = '$',                                                                   mode = mode_nv },

  --c++神器
  { from = '<c-y>',         to = '<ESC>A {}<ESC>i<CR><ESC>ko',                                          mode = mode_i },
  { from = '<leader>k',     to = '<C-w>k' },
  { from = '<leader>j',     to = '<C-w>j' },
  { from = '<leader>h',     to = '<C-w>h' },
  { from = '<leader>l',     to = '<C-w>l' },
  { from = 'qf',            to = '<C-w>o' },
  { from = 's',             to = '<nop>' },
  { from = 'sk',            to = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>',                  desc = 'Move focus to the upper window' },
  { from = 'sj',            to = ':set splitbelow<CR>:split<CR>',                                       desc = 'Move focus to the lower window' },
  { from = 'sh',            to = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>',                 desc = 'Move focus to the left window' },
  { from = 'sl',            to = ':set splitright<CR>:vsplit<CR>',                                      desc = 'Move focus to the right window' },

  { from = '<up>',          to = ':res +5<CR>' },
  { from = '<down>',        to = ':res -5<CR>' },
  { from = '<left>',        to = ':vertical resize-5<CR>' },
  { from = '<right>',       to = ':vertical resize+5<CR>' },

  -- Tab management
  { from = 'tmh',           to = ':-tabmove<CR>' },
  { from = 'tml',           to = ':+tabmove<CR>' },

  -- Other
  { from = '<leader>sw',    to = ':set wrap<CR>' },                                                     --开启自动换行
  { from = '<leader>sc',    to = ':set spell!<CR>' },                                                   --检查拼写错误
  { from = '<leader><CR>',  to = ':nohlsearch<CR>' },                                                   --取消语法高亮
  { from = '<f10>',         to = ':TSHighlightCapturesUnderCursor<CR>' },                               --用于显示光标下的语法捕获组
  { from = '<leader>o',     to = 'za' },                                                                --折叠函数
  { from = '<leader>pr',    to = ':profile start profile.log<CR>:profile func *<CR>:profile file *<CR>' }, --nvim的性能分析
  { from = '<leader><esc>', to = '<nop>' },
  { from = 'q',             to = '<nop>' },
  { from = '<',             to = '<gv',                                                                 mode_v },
  { from = '>',             to = '<gv',                                                                 mode_v },
  { from = '<',             to = '<<' },
  { from = '>',             to = '>>' },
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
  if #buffers > 1 then                                -- 如果有多个缓冲区，执行 bdelete 关闭当前缓冲区
    vim.cmd 'bdelete!'
  else                                                -- 否则执行 :q 退出
    vim.cmd 'q'
  end
end, { noremap = true, silent = true, desc = 'Close buffer or quit Vim' })

--诊断
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- 绑定 <leader>d 切换浮动诊断消息的显示/隐藏
vim.keymap.set('n', '<leader>d', function()
  local diagnostics = vim.diagnostic.get(0) -- 获取当前缓冲区的诊断信息
  if #diagnostics > 0 then
    vim.diagnostic.hide()                   -- 如果有诊断信息，隐藏它
  else
    vim.diagnostic.show()                   -- 如果没有诊断信息，显示它
  end
end, { desc = 'Toggle floating diagnostic message' })

---------------------------------------------------------------------------------------- Terminal ------------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap('t', 'KJ', [[<C-\><C-n>]], { noremap = true, desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set('n', 'T', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 25)
  vim.cmd 'startinsert' -- 进入插入模式
end)

----------------------------------------------------------------------------------------FL Terminal ----------------------------------------------------------------------------------------------------

local state = {
  floating = {
    buf = nil, -- 用于存储当前终端的缓冲区
    win = nil, -- 用于存储当前终端的窗口
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer

  -- Set the buffer to be modifiable
  vim.api.nvim_buf_set_option(buf, 'modifiable', true)

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  -- Add terminal content
  vim.cmd 'terminal'

  -- Enter insert mode after opening the terminal
  vim.cmd 'startinsert'

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if state.floating.win == nil or not vim.api.nvim_win_is_valid(state.floating.win) then
    -- Create a new terminal window if the previous one doesn't exist or is invalid
    state.floating = create_floating_window()
  else
    -- Hide the terminal window if it exists
    vim.api.nvim_win_hide(state.floating.win)
    state.floating.win = nil -- Clear the stored window ID
  end
end

-- Create the command to toggle the terminal
vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})

-- Map <F1> to open/close the floating terminal
vim.keymap.set({ 'n', 't' }, '<F1>', toggle_terminal, { noremap = true, silent = true })
