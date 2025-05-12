-- lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.x', -- 使用稳定版本
    cmd = "Telescope", -- 命令触发加载
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- 推荐安装 fzf native 扩展以获得更好的性能
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
      -- 注意: Windows 上编译 telescope-fzf-native 可能需要安装 make 工具链
      -- 可以尝试 `winget install GnuWin32.Make` 或通过 scoop/chocolatey 安装
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          -- 默认配置...
          file_ignore_patterns = {"%.git/", "node_modules/", "%.cache/"},
          layout_strategy = 'horizontal',
           layout_config = {
                horizontal = { preview_width = 0.55 },
           },
           sorting_strategy = "ascending",
           border = {},
           borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
           color_devicons = true,
        },
        pickers = {
          -- pickers 配置...
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- 启用模糊查找
            override_generic_sorter = true,  -- 重写通用排序器
            override_file_sorter = true,     -- 重写文件排序器
            case_mode = "smart_case",        -- 智能大小写模式
          }
        }
      })
      -- 加载 fzf native 扩展
      pcall(telescope.load_extension, "fzf")

      -- 定义快捷键
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
      keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find Buffers' })
      keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Tags' })
      keymap('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'Find Old Files' })
      keymap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', {desc = 'Git Commits'})
      keymap('n', '<leader>gs', '<cmd>Telescope git_status<cr>', {desc = 'Git Status'})
    end
  }
}