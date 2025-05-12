--[[
  utils.lua - 实用工具插件配置文件
  
  本文件配置各种提升编辑效率的工具插件：

  1. nvim-autopairs
     - 自动配对括号和引号
     - 智能配对规则
     - 支持多种编程语言

  2. Comment.nvim
     - 智能注释工具
     - 支持多种注释风格
     - 支持选区注释

  3. gitsigns.nvim
     - Git 集成
     - 显示文件变更
     - 支持 hunk 操作
     - 行内 blame 信息

  4. toggleterm.nvim
     - 集成终端
     - 支持多种终端布局
     - 快捷键切换
     - 命令运行

  5. nvim-surround
     - 快速修改包围字符
     - 支持多种包围类型
     - 可视模式支持

  6. flash.nvim
     - 增强的搜索和跳转
     - 支持 Treesitter
     - 多窗口跳转

  快捷键：
  - 终端：<C-\>
  - 垂直分割终端：<leader>tv
  - 水平分割终端：<leader>th
  - Git 操作：<leader>h* 系列
  - 快速跳转：s, S
--]]

-- lua/plugins/utils.lua
return {
    -- 自动配对
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function ()
        require("nvim-autopairs").setup({})
        -- print("Nvim-Autopairs loaded.")
      end
    },
  
    -- 注释切换
    {
      "numToStr/Comment.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function ()
        require("Comment").setup({})
        -- print("Comment.nvim loaded.")
      end
    },
  
    -- Git 状态显示
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function ()
        require("gitsigns").setup({
          -- 配置...
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc }) end
            -- Navigation
            map('n', ']c', function() if vim.wo.diff then return ']c' end vim.schedule(function() gs.next_hunk() end) return '<Ignore>' end, "Next Hunk")
            map('n', '[c', function() if vim.wo.diff then return '[c' end vim.schedule(function() gs.prev_hunk() end) return '<Ignore>' end, "Prev Hunk")
            -- Actions
            map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', "Stage Hunk")
            map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', "Reset Hunk")
            map('n', '<leader>hS', gs.stage_buffer, "Stage Buffer")
            map('n', '<leader>hu', gs.undo_stage_hunk, "Undo Stage Hunk")
            map('n', '<leader>hR', gs.reset_buffer, "Reset Buffer")
            map('n', '<leader>hp', gs.preview_hunk, "Preview Hunk")
            map('n', '<leader>hb', function() gs.blame_line{full=true} end, "Blame Line")
            map('n', '<leader>tb', gs.toggle_current_line_blame, "Toggle Line Blame")
            map('n', '<leader>hd', gs.diffthis, "Diff This")
            map('n', '<leader>hD', function() gs.diffthis('~') end, "Diff This ~")
            map('n', '<leader>td', gs.toggle_deleted, "Toggle Delete")
          end
        })
        -- print("Gitsigns loaded.")
      end
    },
  
    -- 终端管理
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      cmd = "ToggleTerm",
      config = function ()
        require("toggleterm").setup({
          size = 20, -- 终端窗口大小
          open_mapping = [[<c-\>]], -- Ctrl + \ 打开/关闭终端
          hide_numbers = true,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = true,
          direction = 'float', -- 浮动窗口
          close_on_exit = true,
          shell = vim.o.shell,
        })
        -- print("Toggleterm loaded.")
        -- 定义一个更方便的垂直分割终端映射
         vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', {desc = 'ToggleTerm vertical split'})
         vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', {desc = 'ToggleTerm horizontal split'})
      end
    },
  
    -- 包围操作
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration options...
          })
          print("Nvim-Surround loaded.")
      end
    },
  
    -- 快速跳转
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        config = function() print("Flash.nvim loaded.") end
    },
  }