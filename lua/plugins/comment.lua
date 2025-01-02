--这是代码块的注释插件
return {
  'tomtom/tcomment_vim',
  event = 'BufRead',
  config = function()
    vim.g.tcomment_maps = true
    vim.g.tcomment_textobject_inlinecomment = ''
    --
    vim.cmd [[
nmap <LEADER>cm g>c
vmap <LEADER>cm g>
nmap <LEADER>uc g<c
vmap <LEADER>uc g<
unmap ic
		]]
  end,
}
