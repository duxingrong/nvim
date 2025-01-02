return {
  -- 添加 luasnip 和 friendly-snippets 插件
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load() -- 加载来自 VSCode 的片段
    end,
  },
  {
    'saadparwaiz1/cmp_luasnip', -- 支持 cmp 和 luasnip 配合使用
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').snippet_expand(args.body) -- 扩展 luasnip 片段
          end,
        },
      }
    end,
  },
}
