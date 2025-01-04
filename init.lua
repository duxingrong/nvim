require 'config.defaults'
require 'config.plugins'
require 'config.keymaps'

--title
vim.g._nvim_path = '/home/du/.config/nvim/'
vim.g.psw = 'root'

-- 输出消息
vim.cmd "echo 'your time  is limited!'"

-- wezterm透明度
vim.keymap.set('n', '<leader>bg', function()
  vim.cmd 'silent !python3 ~/.config/nvim/lua/scripts/wezterm.py'
end)
