--[[
  lsp.lua - LSP（Language Server Protocol）配置文件
  
  本文件配置所有与语言服务器相关的功能，包括：

  1. mason.nvim
     - LSP 服务器管理器
     - 提供图形化界面
     - 支持安装和更新 LSP 服务器

  2. mason-lspconfig.nvim
     - mason.nvim 和 nvim-lspconfig 的桥接插件
     - 自动化 LSP 服务器配置
     - 确保 LSP 服务器的正确设置

  3. nvim-lspconfig
     - LSP 客户端配置
     - 提供开箱即用的 LSP 服务器配置
     - 支持自定义 LSP 设置

  主要功能：
  - 代码补全
  - 语法检查
  - 代码跳转
  - 符号搜索
  - 代码重构
  - 实时诊断

  快捷键设置：
  - gd: 转到定义
  - gr: 查看引用
  - K: 显示悬浮文档
  - <leader>rn: 重命名
  - <leader>ca: 代码操作
  等...
--]]

-- lua/plugins/lsp.lua
return {
    -- LSP 安装和管理
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      config = function()
        require("mason").setup({
          ui = {
            border = "rounded",
          },
          -- 注释掉自动安装的工具，改为手动安装
          -- ensure_installed = {
          --   "clang-format", 
          --   "black",
          --   "ruff",
          --   "stylua",
          --   "prettier"
          -- },
        })
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
      opts = {
        -- 注释掉自动安装的 LSP 服务器，改为手动安装
        -- ensure_installed = {
        --   "lua_ls",
        --   "clangd",     -- For C/C++
        --   "pyright",    -- For Python
        --   "bashls",
        --   "tsserver",   -- For JavaScript/TypeScript
        --   "html",
        --   "cssls",
        --   "jsonls",
        --   "yamlls"
        -- },
        -- automatic_installation = false, -- 禁用自动安装
      },
      config = function(_, opts)
          require("mason-lspconfig").setup(opts)
      end,
    },

    -- LSP 核心配置 (nvim-lspconfig)
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
      config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local on_attach = function(client, bufnr)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
          map('n', 'gr', vim.lsp.buf.references, 'Go to References')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
          map('n', '<leader>D', vim.lsp.buf.type_definition, 'Go to Type Definition')
          map('n', 'gh', vim.lsp.buf.hover, 'Hover Documentation')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
          map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          map('n', '<leader>e', vim.diagnostic.open_float, 'Show Line Diagnostics')
          map('n', '[d', vim.diagnostic.goto_prev, 'Go to Previous Diagnostic')
          map('n', ']d', vim.diagnostic.goto_next, 'Go to Next Diagnostic')

          if package.loaded.conform then
              require("conform").setup {
                  formatters_by_ft = {
                      -- 格式化配置将在 conform.nvim 插件中定义
                  }
              }
          end
        end

        -- 手动配置已安装的 LSP 服务器
        -- 你需要先手动安装这些服务器，然后取消注释相应的配置

        -- Lua
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    diagnostics = { globals = {'vim'} },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false },
                },
            },
        })

        -- Python
        -- lspconfig.pyright.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- })

        -- C/C++
        -- lspconfig.clangd.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- })

        -- JavaScript/TypeScript
        -- lspconfig.tsserver.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- })

        -- 其他语言服务器配置...
      end,
    },
}