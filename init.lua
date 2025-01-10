require 'config.defaults'
require 'config.plugins'
require 'config.keymaps'

--title
vim.g._nvim_path = '/home/du/.config/nvim/'
vim.g.psw = 'root'

-- 输出消息
vim.cmd "echo 'fake it till you make it'"

-- wezterm透明度
vim.keymap.set('n', '<leader>bg', function()
  vim.cmd 'silent !python3 ~/.config/nvim/lua/scripts/wezterm.py'
end)

-- 识别 .launch 文件并设置为 xml 文件类型
vim.cmd [[
  augroup LaunchFileHighlight
    autocmd!
    autocmd BufRead,BufNewFile *.launch set filetype=xml
  augroup END
]]
