--[[
  completion.lua - 代码补全配置文件
  
  本文件配置代码补全系统，使用：

  1. nvim-cmp
     - 强大的补全引擎
     - 支持多种补全源
     - 异步补全
     - 高度可定制

  补全源：
  - cmp-nvim-lsp: LSP 补全
  - cmp-buffer: 当前缓冲区补全
  - cmp-path: 文件路径补全
  - cmp-cmdline: 命令行补全
  - cmp_luasnip: 代码片段补全

  其他组件：
  - LuaSnip: 代码片段引擎
  - friendly-snippets: 预定义代码片段集合

  快捷键：
  - <C-Space>: 触发补全
  - <CR>: 确认选择
  - <Tab>: 下一个选项
  - <S-Tab>: 上一个选项
  - <C-b>/<C-f>: 滚动文档
  - <C-e>: 取消补全
--]]

-- lua/plugins/completion.lua
return {
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter", -- 进入插入模式时加载
      dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP 来源
        "hrsh7th/cmp-buffer",   -- Buffer 来源
        "hrsh7th/cmp-path",     -- Path 来源
        "hrsh7th/cmp-cmdline",  -- Cmdline 来源
        "L3MON4D3/LuaSnip",     -- Snippet 引擎
        "saadparwaiz1/cmp_luasnip", -- Snippet 来源 for nvim-cmp
        "rafamadriz/friendly-snippets", -- Snippet 集合
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
  
        -- 加载 snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        luasnip.config.setup({})
  
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          sources = cmp.config.sources({
            { name = "nvim_lsp" }, -- LSP 优先
            { name = "luasnip" },  -- 然后是 Snippets
            { name = "buffer" },   -- 然后是 Buffer
            { name = "path" },     -- 最后是 Path
          }),
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- 向下滚动文档
            ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- 向上滚动文档
            ['<C-Space>'] = cmp.mapping.complete(), -- 手动触发补全
            ['<C-e>'] = cmp.mapping.abort(),       -- 中止补全
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 选择当前项
            ["<Tab>"] = cmp.mapping(function(fallback) -- Tab 选择下一项或展开 Snippet
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { "i", "s" }), -- i=insert mode, s=select mode
            ["<S-Tab>"] = cmp.mapping(function(fallback) -- Shift+Tab 选择上一项或跳到 Snippet 上一个位置
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          window = { -- 补全窗口外观
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          formatting = { -- 补全项格式 (加图标等)
             fields = { 'menu', 'abbr', 'kind' },
              format = function(entry, vim_item)
                  local kind_icons = require('utils.icons').kind -- 需要定义图标文件
                  vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '?', vim_item.kind)
                  vim_item.menu = ({
                      nvim_lsp = "[LSP]",
                      luasnip = "[Snip]",
                      buffer = "[Buf]",
                      path = "[Path]",
                  })[entry.source.name]
                  return vim_item
              end,
          },
        })
  
        -- 命令行模式补全
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } }
        })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
        })
        -- print("Nvim-Cmp loaded.")
      end,
    },
    -- (可选) 添加 utils/icons.lua 文件来定义补全图标
    -- { 'nvim-tree/nvim-web-devicons' } -- 已经在 ui.lua 中作为依赖添加
  }
  -- 你需要在 lua/utils/icons.lua (或直接在上面 config 中) 定义 kind_icons
  -- 例如:
  -- lua/utils/icons.lua
  -- return {
  --   kind = {
  --     Text = "󰉿", -- Nerd Font 图标
  --     Method = "󰆧",
  --     Function = "󰊕",
  --     -- ... 其他图标
  --   }
  -- }
  -- 然后在 completion.lua 中 local kind_icons = require('utils.icons').kind