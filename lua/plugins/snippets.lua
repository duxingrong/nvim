return {
  {
    'SirVer/ultisnips',
    dependencies = {
      'honza/vim-snippets',
    },
    config = function()
      vim.g.UltiSnipsSnippetDirectories = { '/home/du/.config/nvim/Ultisnips' }
      --vim.g.UltiSnipsExpandTrigger = "<C-e>"
      --vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      --vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
    end,
  },
}
