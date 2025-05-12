--[[
  ui.lua - Neovim UI 相关插件配置
  
  本文件配置所有与用户界面相关的插件，包括：

  1. tokyonight.nvim
     - 现代化的配色方案
     - 支持多种风格：storm, night, day, moon
     - 完整的 LSP, Treesitter 支持

  2. dashboard-nvim
     - 美观的启动界面
     - 快速访问最近文件
     - 常用操作快捷方式

  3. lualine.nvim
     - 强大的状态栏
     - 支持 Git 分支显示
     - LSP 状态集成
     - 文件信息显示

  4. nvim-tree.lua
     - 文件树浏览器
     - 支持文件操作
     - Git 状态集成
     - 图标支持

  5. nvim-web-devicons
     - 文件图标支持
     - 为其他插件提供图标

  6. indent-blankline.nvim
     - 缩进指示线
     - 代码结构可视化
     - 支持不同缩进风格
--]]

-- lua/plugins/ui.lua
return {
    -- 主题
    {
      "folke/tokyonight.nvim",
      lazy = false, -- 主题需要立即加载
      priority = 1000, -- 确保在其他 UI 插件之前加载
      config = function()
        require("tokyonight").setup({
          style = "storm", -- 可选: night, storm, day, moon
          terminal_colors = true,
          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
        })
        vim.cmd.colorscheme "tokyonight" -- 应用主题
        -- print("TokyoNight theme loaded.")
      end,
    },
  
    -- 启动界面
    {
      'nvimdev/dashboard-nvim',
      event = 'VimEnter',
      dependencies = { {'nvim-tree/nvim-web-devicons'}},
      config = function()
        require('dashboard').setup {
          theme = 'doom',
          config = {
            header = {
                "                                                       ",
                "                                                       ",
                "                                                       ",
                " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                "                                                       ",
                "                                                       ",
                "                                                       ",
            },
            center = {
              {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find File',
                desc_hl = 'String',
                key = 'f',
                keymap = 'SPC f f',
                key_hl = 'Number',
                action = 'Telescope find_files'
              },
              {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find Text',
                desc_hl = 'String',
                key = 'w',
                keymap = 'SPC f g',
                key_hl = 'Number',
                action = 'Telescope live_grep'
              },
              {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Recent Files',
                desc_hl = 'String',
                key = 'r',
                keymap = 'SPC f o',
                key_hl = 'Number',
                action = 'Telescope oldfiles'
              },
              {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Config',
                desc_hl = 'String',
                key = 'c',
                keymap = 'SPC f c',
                key_hl = 'Number',
                action = 'e ~/.config/nvim/init.lua'
              },
            },
            footer = {"🚀 Happy Coding!"}
          }
        }
      end
    },
  
    -- 状态栏
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- 需要图标
      config = function()
        require("lualine").setup({
          options = {
            theme = 'tokyonight', -- 使用主题的样式
            -- 其他 lualine 配置...
          },
          sections = {
            lualine_c = {
              {'filename', path = 1} -- 显示相对路径的文件名
            },
            -- 其他部分配置...
          }
        })
        -- print("Lualine loaded.")
      end,
    },
  
    -- 文件浏览器
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      cmd = "NvimTreeToggle", -- 命令触发加载
      config = function()
        require("nvim-tree").setup({
          -- NvimTree 配置...
          sort_by = "case_sensitive",
          view = {
            width = 30,
          },
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = true,
          },
        })
        print("NvimTree loaded.")
      end,
      -- 添加一个快捷键来开关文件树
      keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
      },
    },
  
    -- 图标
    { "nvim-tree/nvim-web-devicons", lazy = true },
  
    -- 缩进线
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
      config = function()
          require("ibl").setup({
              indent = { char = "│" }, -- 使用竖线作为缩进线
              scope = { enabled = false }, -- 可以启用 scope 高亮
          })
          print("Indent Blankline loaded.")
      end,
      event = {"BufReadPre", "BufNewFile"} -- 在打开文件时加载
    },
  }