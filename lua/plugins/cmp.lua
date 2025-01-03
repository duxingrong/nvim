local setCompHL = function()
  local fgdark = '#2E3440'

  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })

  vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#808080', bg = 'NONE', italic = true })
  vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = fgdark, bg = '#B5585F' })
  vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = fgdark, bg = '#B5585F' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = fgdark, bg = '#B5585F' })

  vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = fgdark, bg = '#9FBD73' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = fgdark, bg = '#9FBD73' })
  vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = fgdark, bg = '#9FBD73' })

  vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = fgdark, bg = '#D4BB6C' })
  vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = fgdark, bg = '#D4BB6C' })
  vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = fgdark, bg = '#D4BB6C' })

  vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = fgdark, bg = '#A377BF' })
  vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = fgdark, bg = '#A377BF' })
  vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = fgdark, bg = '#A377BF' })
  vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = fgdark, bg = '#A377BF' })
  vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = fgdark, bg = '#A377BF' })

  vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = fgdark, bg = '#cccccc' })
  vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = fgdark, bg = '#7E8294' })

  vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = fgdark, bg = '#D4A959' })
  vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = fgdark, bg = '#D4A959' })
  vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = fgdark, bg = '#D4A959' })

  vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = fgdark, bg = '#6C8ED4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = fgdark, bg = '#6C8ED4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = fgdark, bg = '#6C8ED4' })

  vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = fgdark, bg = '#58B5A8' })
  vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = fgdark, bg = '#58B5A8' })
  vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = fgdark, bg = '#58B5A8' })
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local moveCursorBeforeComma = function()
  if vim.bo.filetype ~= 'dart' then
    return
  end
  vim.defer_fn(function()
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local char = line:sub(col - 2, col)
    if char == ': ,' then
      vim.api.nvim_win_set_cursor(0, { row, col - 1 })
    end
  end, 100)
end

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

      setCompHL()

      -- 配置自动补全
      cmp.setup {
        preselect = cmp.PreselectMode.None, -- 禁止自动预选第一行

        snippet = {
          expand = function(args)
            -- 使用 LuaSnip 扩展片段
            luasnip.lsp_expand(args.body)
          end,
        },

        -- 快捷键配置
        mapping = cmp.mapping.preset.insert {

          ['<Tab>'] = cmp.mapping {
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
                moveCursorBeforeComma()
              elseif has_words_before() then
                cmp.complete()
                moveCursorBeforeComma()
              else
                fallback()
              end
            end,
          },
          ['<S-Tab>'] = cmp.mapping {
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
                moveCursorBeforeComma()
              else
                fallback()
              end
            end,
          },

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
          { name = 'path' },
          { name = 'luasnip' },
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
