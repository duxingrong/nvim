return {

  {
    'RRethy/vim-illuminate', --用于高亮当前的单词
    config = function()
      require('illuminate').configure {
        providers = {
          -- 'lsp',
          -- 'treesitter',
          'regex',
        },
      }
      vim.cmd 'hi IlluminatedWordText guibg=#393E4D gui=none'
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter', -- 当进入插入模式时加载插件
    dependencies = { 'hrsh7th/nvim-cmp' }, -- 依赖于 nvim-cmp 插件（如果你使用自动补全的话）
    config = function()
      require('nvim-autopairs').setup {} -- 加载 nvim-autopairs 插件
      -- 配置自动补全配对符号
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      -- 让 nvim-cmp 在确认补全时，自动处理括号配对
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { 'gcmt/wildfire.vim', lazy = false },
  {
    'shellRaining/hlchunk.nvim',
    init = function()
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { pattern = '*', command = 'EnableHL' })
      require('hlchunk').setup {
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = '#806d9c' },
          },
        },
        indent = {
          chars = { '│', '¦', '┆', '┊' },
          use_treesitter = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          use_treesitter = true,
        },
      }
    end,
  },
  {
    'kevinhwang91/nvim-hlslens', --*来将当前词高亮
    lazy = false,
    enabled = true,
    keys = {
      {
        'n',
        [[<cmd>execute('normal! ' . v:count1 . 'n')<cr>]] .. [[<cmd>lua require("hlslens").start()<cr>]],
      },
      {
        'm',
        [[<cmd>execute('normal! ' . v:count1 . 'N')<cr>]] .. [[<cmd>lua require("hlslens").start()<cr>]],
      },
      { '*', '*' .. [[<cmd>lua require("hlslens").start()<cr>]] },
      --		{ "#",  "#" .. [[<cmd>lua require("hlslens").start()<cr>]] },
      --		{ "g*", "g*" .. [[<cmd>lua require("hlslens").start()<cr>]] },
      { 'g#', 'g#' .. [[<cmd>lua require("hlslens").start()<cr>]] },
    },
    config = function()
      require('scrollbar.handlers.search').setup()
    end,
  },
  {
    'nvim-pack/nvim-spectre', --<leader>F快速查找和替换
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        'F',
        mode = 'n',
        function()
          require('spectre').open()
        end,
        desc = 'Project find and replace',
      },
    },
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      local group = vim.api.nvim_create_augroup('scrollbar_set_git_colors', {})
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '*',
        callback = function()
          vim.cmd [[
hi! ScrollbarGitAdd guifg=#8CC85F
hi! ScrollbarGitAddHandle guifg=#A0CF5D
hi! ScrollbarGitChange guifg=#E6B450
hi! ScrollbarGitChangeHandle guifg=#F0C454
hi! ScrollbarGitDelete guifg=#F87070
hi! ScrollbarGitDeleteHandle guifg=#FF7B7B ]]
        end,
        group = group,
      })
      require('scrollbar.handlers.search').setup {}
      require('scrollbar.handlers.gitsigns').setup()
      require('scrollbar').setup {
        show = true,
        handle = {
          text = ' ',
          color = '#928374',
          hide_if_all_visible = true,
        },
        marks = {
          Search = { color = 'yellow' },
          Misc = { color = 'purple' },
        },
        handlers = {
          cursor = false,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = true,
        },
      }
    end,
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
