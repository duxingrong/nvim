return {
  {
    'instant-markdown/vim-instant-markdown',
    ft = { 'markdown' },
    build = 'yarn install',
    config = function()
      vim.g.instant_markdown_autostart = 0
    end,
  },

  {
    'Kicamon/markdown-table-mode.nvim',
    config = function()
      require('markdown-table-mode').setup()
    end,
  },
}
