return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 20,           -- 下方终端的高度
      hide_numbers = true, -- 隐藏行号
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,     -- 终端背景明暗度
      start_in_insert = true, -- 打开后直接进入插入模式
      insert_mappings = true, -- 允许插入模式映射
      persist_size = true,    -- 记住终端大小
      direction = 'float',    -- 默认方向为水平分割
      close_on_exit = true,   -- 退出时关闭终端
      shell = vim.o.shell,    -- 使用默认 shell
    },
    keys = {
      { ':', '<cmd>ToggleTerm direction=float<CR>', desc = '浮动终端' },
      { 'T', '<cmd>ToggleTerm direction=horizontal<CR>', desc = '终端' },
    },
  },
}
