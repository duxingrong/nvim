-- ~/.config/nvim/lua/config/plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 使用稳定分支
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

require('lazy').setup({

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  require 'plugins/colorscheme',
  require 'plugins.neo-tree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins/telescope',
  require 'plugins/lspconfig',
  require 'plugins.cmp',
  require 'plugins.autoformatting',
  require 'plugins/gitsigns',
  require 'plugins/which-key',
  require 'plugins/alpha',
  require 'plugins.autopairs',
  require 'plugins.comment',
  require 'plugins.fun',
  require 'plugins.notify',
  require 'plugins.yazi',
  require 'plugins.multi-cursor',
  require 'plugins.undo',
  require 'plugins.wilder',
  require 'plugins.conform',
  require 'plugins.project',
  require 'plugins.markdown',
  require 'plugins.luasnip',
  require 'plugins.misc',
  require 'plugins.snacks',
  require 'plugins.terminal',
  require 'plugins.flash',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
