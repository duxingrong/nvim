local mode_nv = { 'n', 'v' }
local mode_v = { 'v' }
local mode_i = { 'i' }
local mode_t = { 't' }

local nmappings = {
	{ from = 'S',            to = ':w<CR>' },
	{ from = ';',            to = ':',                                                   mode = mode_nv },
	{ from = 'Y',            to = '"+y',                                                 mode = mode_v },
	{ from = '`',            to = '~',                                                   mode = mode_nv },
	--用kj代替<ESC>
	{ from = 'kj',           to = '<ESC>',                                               mode = mode_i },

	{ from = 'K',            to = '7k',                                                  mode = mode_nv },
	{ from = 'J',            to = '7j',                                                  mode = mode_nv },
	{ from = 'N',            to = '0',                                                   mode = mode_nv },
	{ from = 'M',            to = '$',                                                   mode = mode_nv },

	--c++神器
	{ from = '<c-y>',        to = '<ESC>A {}<ESC>i<CR><ESC>ko',                          mode = mode_i },
	{ from = '<leader>k',    to = '<C-w>k' },
	{ from = '<leader>j',    to = '<C-w>j' },
	{ from = '<leader>h',    to = '<C-w>h' },
	{ from = '<leader>l',    to = '<C-w>l' },
	{ from = 's',            to = '<nop>' },
	{ from = 'sk',           to = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>',  desc = 'Move focus to the upper window' },
	{ from = 'sj',           to = ':set splitbelow<CR>:split<CR>',                       desc = 'Move focus to the lower window' },
	{ from = 'sh',           to = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>', desc = 'Move focus to the left window' },
	{ from = 'sl',           to = ':set splitright<CR>:vsplit<CR>',                      desc = 'Move focus to the right window' },

	{ from = '<up>',         to = ':res +5<CR>' },
	{ from = '<down>',       to = ':res -5<CR>' },
	{ from = '<left>',       to = ':vertical resize-5<CR>' },
	{ from = '<right>',      to = ':vertical resize+5<CR>' },

	-- Other
	{ from = '<leader>sc',   to = ':set spell!<CR>' }, --检查拼写错误
	{ from = '<leader><CR>', to = ':nohlsearch<CR>' }, --取消语法高亮
	{ from = '<leader>o',    to = 'za' },              --折叠函数
	{ from = 'q',            to = '<nop>' },
	{ from = '<',            to = '<gv',                                                 mode_v },
	{ from = '>',            to = '<gv',                                                 mode_v },
	{ from = '<',            to = '<<' },
	{ from = '>',            to = '>>' },
}

--循环设置案件映射
for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to, { desc = mapping.desc })
end

--退出终端模式
vim.keymap.set('t', 'KJ', [[<C-\><C-n>]], { noremap = true, silent = true })
--脚本
require 'scripts.compile_run'


vim.keymap.set('n', 'Q', function()
    -- 获取所有已列出的缓冲区 (你可以理解为所有打开的文件)
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })

    -- 判断缓冲区的数量
    if #buffers > 1 then
        -- 如果缓冲区数量大于1，说明还有其他文件，
        -- 那么就执行“保存并关闭当前”
        vim.cmd('update | bdelete')
    else
        -- 如果缓冲区数量小于等于1 (即这是最后一个文件)，
        -- 那么就执行“保存并退出程序”
        vim.cmd('q!') -- wq = write and quit (写入并退出)
    end
end, { noremap = true, silent = true, desc = 'Save and close buffer, or quit if last' })
