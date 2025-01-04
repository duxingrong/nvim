local split = function()
  vim.cmd 'set splitbelow'
  vim.cmd 'sp'
  vim.cmd 'res -2'
end
local compileRun = function()
  vim.cmd 'w'
  -- check file type
  local ft = vim.bo.filetype
  if ft == 'dart' then
    vim.cmd(':FlutterRun -d ' .. vim.g.flutter_default_device .. ' ' .. vim.g.flutter_run_args)
  elseif ft == 'markdown' then
    vim.cmd ':InstantMarkdownPreview'
  elseif ft == 'c' then
    split()
    vim.cmd 'term gcc % -o %< && ./%< && rm %<'
    vim.cmd 'startinsert'
  elseif ft == 'cpp' then
    split()
    vim.cmd 'term g++ % -o %< && ./%< && rm %<'
    vim.cmd 'startinsert'
  elseif ft == 'javascript' then
    split()
    vim.cmd 'term node %'
    vim.cmd 'startinsert'
  elseif ft == 'lua' then
    split()
    vim.cmd 'term luajit %'
    vim.cmd 'startinsert'
  elseif ft == 'tex' then
    vim.cmd ':VimtexCompile'
    vim.cmd 'startinsert'
  elseif ft == 'python' then
    split()
    vim.cmd 'term python3 %'
    vim.cmd 'startinsert'
  elseif ft == 'sh' then
    split()
    vim.cmd 'term bash %'
    vim.cmd 'startinsert'
  end
end

vim.keymap.set('n', 'r', compileRun, { silent = true })
