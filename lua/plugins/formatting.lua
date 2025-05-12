--[[
  formatting.lua - 代码格式化配置文件
  
  本文件配置代码格式化相关功能，使用：

  1. conform.nvim
     - 现代化的代码格式化工具
     - 支持多种格式化器
     - 异步格式化
     - 保存时自动格式化
     - LSP 格式化回退支持

  支持的格式化器：
  - stylua (Lua)
  - clang-format (C/C++)
  - black, ruff (Python)
  - prettier (JavaScript, TypeScript, HTML, CSS, JSON, YAML, Markdown)

  使用方式：
  1. 手动格式化：<leader>f
  2. 保存时自动格式化
  3. 支持选区格式化

  注意：需要手动安装相应的格式化工具
--]]

-- lua/plugins/formatting.lua
return {
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" }, -- 在写入缓冲区之前加载
      cmd = { "ConformInfo" },
      opts = {
        -- 注释掉格式化工具配置，改为手动安装后取消注释
        formatters_by_ft = {
          -- lua = { "stylua" },
          -- c = { "clang-format" },
          -- cpp = { "clang-format" },
          -- python = { "ruff_format", "black" },
          -- javascript = { "prettier" },
          -- typescript = { "prettier" },
          -- html = { "prettier" },
          -- css = { "prettier" },
          -- json = { "prettier" },
          -- yaml = { "prettier" },
          -- markdown = { "prettier" },
        },
  
        -- 添加在保存时自动格式化的功能
        format_on_save = {
          timeout_ms = 500, -- 格式化超时时间
          lsp_fallback = true, -- 如果没有配置的格式化工具，则尝试使用 LSP 的格式化能力
        },
      },
       config = function(_, opts)
          require("conform").setup(opts)
          -- print("Conform.nvim loaded for formatting.")
  
          -- 创建自动命令组，确保配置重载时不会重复创建自动命令
          vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
          -- 创建自动命令，在 BufWritePre 事件（保存前）触发格式化
          vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*", -- 对所有文件生效
              group = "FormatOnSave",
              callback = function(args)
                  require("conform").format({ bufnr = args.buf, async = false, lsp_fallback = true })
                  -- print("Auto formatting on save triggered for buffer: " .. args.buf)
              end,
          })
  
           -- 添加手动格式化快捷键 (覆盖或替代 LSP 的 <leader>f)
           vim.keymap.set({"n", "v"}, "<leader>f", function()
               require("conform").format({ async = true, lsp_fallback = true })
           end, {noremap = true, silent = true, desc = "Format Code (Conform)"})
      end,
    },
  }