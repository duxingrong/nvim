return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- 定义函数
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()  -- 按下 `<leader>hs` 暂存选中的行
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()  -- 按下 `<leader>hr` 重置选中的行
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })  -- 暂存当前修改
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })  -- 重置当前修改
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })  -- 暂存整个文件的修改
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })  -- 撤销暂存
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })  -- 重置整个文件
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })  -- 查看当前修改的预览
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })  -- 查看当前行的 Git blame
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })  -- 查看与暂存区的差异
        map('n', '<leader>hD', function()  -- 查看与上次提交的差异
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
      end
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
