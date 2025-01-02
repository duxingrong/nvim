return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- Bufferline 设置
    require('bufferline').setup {
      options = {
        mode = 'buffers', -- 选择显示模式，'buffers' 或 'tabs'
        themable = true, -- 允许自定义高亮组
        numbers = 'none', -- 显示缓冲区编号方式
        close_command = 'Bdelete! %d', -- 关闭缓冲区的命令
        right_mouse_command = 'Bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        buffer_close_icon = '✗', -- 关闭缓冲区的图标
        close_icon = '', -- 关闭图标
        path_components = 1, -- 显示文件名而不是完整路径
        modified_icon = '●', -- 修改过的文件图标
        left_trunc_marker = '', -- 缩短的左边界标记
        right_trunc_marker = '', -- 缩短的右边界标记
        max_name_length = 30,
        max_prefix_length = 30, -- 缓冲区名称的最大长度
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true,
        separator_style = { '│', '│' }, -- 缓冲区分隔符样式
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = {
          style = 'none', -- 指示器样式
        },
        icon_pinned = '󰐃', -- 固定缓冲区图标
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        sort_by = 'insert_at_end', -- 缓冲区排序方式
      },
      highlights = {
        separator = {
          fg = '#434C5E', -- 分隔符颜色
        },
        buffer_selected = {
          bold = true,
          italic = false,
        },
      },
    }

    -- 键位绑定
    local opts = { noremap = true, silent = true, desc = 'Go to Buffer' }
    
    -- 绑定 <Tab> 和 <S-Tab> 切换缓冲区
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', opts)
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', opts)

    -- 快捷键 1 到 9 跳转到指定的缓冲区
    for i = 1, 9 do
      vim.keymap.set('n', '<leader>'..i, "<cmd>lua require('bufferline').go_to_buffer("..i..")<CR>", opts)
    end
  end,
}
