-- lua/plugins/treesitter.lua
return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate", -- 安装或更新时运行
      event = { "BufReadPost", "BufNewFile" }, -- 文件读取后加载
      config = function()
        require("nvim-treesitter.configs").setup({
          -- 确保安装你需要的语言解析器
          ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "bash", "python", "json", "yaml", "html", "css", "javascript", "typescript" },
          sync_install = false, -- 异步安装解析器
          auto_install = true,  -- 自动安装缺少的解析器
          highlight = {
            enable = true, -- 启用语法高亮
          },
          indent = {
            enable = true, -- 启用基于 Treesitter 的缩进 (可选)
          },
          -- 启用 nvim-treesitter-textobjects
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- V 支持 向前看选择
              keymaps = {
                -- 例如: af / if 选择函数, ac / ic 选择类
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                -- 可以添加更多 text objects
              },
            },
            move = {
               enable = true,
               set_jumps = true, -- 让 ]m 和 [m 跳转到下一个/上一个函数/类
               goto_next_start = {
                 ["]m"] = "@function.outer",
                 ["]c"] = "@class.outer", -- 可自定义
               },
               goto_previous_start = {
                 ["[m"] = "@function.outer",
                 ["[c"] = "@class.outer", -- 可自定义
               },
            },
          },
        })
        print("Nvim-Treesitter loaded and configured.")
      end,
      dependencies = {
          -- 依赖 textobjects 插件
          "nvim-treesitter/nvim-treesitter-textobjects",
      }
    },
  }