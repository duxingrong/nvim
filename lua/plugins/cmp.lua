return {

  { -- Autocompletion

    'hrsh7th/nvim-cmp',

    event = 'InsertEnter',

    dependencies = {

      'L3MON4D3/LuaSnip', -- 使用 LuaSnip

      'hrsh7th/cmp-nvim-lsp',

      'hrsh7th/cmp-path',

      'saadparwaiz1/cmp_luasnip', -- 使用 cmp_luasnip 来支持 LuaSnip
    },

    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- 配置自动补全
      cmp.setup {

        snippet = {
          expand = function(args)
            -- 使用 LuaSnip 扩展片段
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = { completeopt = 'menu,menuone,noinsert' },

        -- 快捷键配置
        mapping = cmp.mapping.preset.insert {

          -- 使用 Tab 和 Shift+Tab 来选择补全项
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- 文档滚动
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- 确认补全
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- 手动触发补全
          ['<C-Space>'] = cmp.mapping.complete {},

          -- 使用 <C-e> 来扩展片段
          ['<C-e>'] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),

          -- 使用 <C-j> 跳转到下一个位置
          ['<C-j>'] = cmp.mapping(function()
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            end
          end, { 'i', 's' }),

          -- 使用 <C-k> 跳转到上一个位置
          ['<C-k>'] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },

        -- 补全来源
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        -- 格式化补全项
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            local kind_icons = {
              Text = ' ',
              Method = 'm',
              Function = 'ƒ',
              Constructor = '',
              Field = '',
              Variable = '',
              Class = '',
              Interface = 'ﰮ',
              Module = '',
              Property = '',
              Unit = '',
              Value = '',
              Enum = 'ℰ',
              Keyword = '',
              Snippet = '',
              Color = '',
              File = '',
              Reference = '',
              Folder = '',
              EnumMember = '',
              Constant = '',
              Struct = '',
              Event = '',
              Operator = '',
              TypeParameter = '',
            }

            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]

            return vim_item
          end,
        },
      }
    end,
  },
}
