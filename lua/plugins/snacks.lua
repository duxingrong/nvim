return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    win = { enabled = true },
    scroll = { enabled = true },
    dim = { enabled = true },
    zen = {
      {
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = false,
          inlay_hints = false,
        },
        options = {
          number = false, -- 禁用行号
          relativenumber = false, -- 禁用相对行号
        },
        show = {
          statusline = false, -- can only be shown when using the global statusline
          tabline = false,
        },
        win = { style = 'zen' },
        --- Callback when the window is opened.
        on_open = function(win) end,
        --- Callback when the window is closed.
        on_close = function(win) end,
      },
    },
  },
  keys = {
    {
      'zz',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
  },
}
