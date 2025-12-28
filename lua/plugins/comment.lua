return {
	"tomtom/tcomment_vim",
	event = "BufRead",
	config = function()
		vim.g.tcomment_maps = true
		vim.g.tcomment_textobject_inlinecomment = ''

		vim.cmd([[
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>uc g<c
vmap <LEADER>uc g<
unmap ic
		]])
	end
}
