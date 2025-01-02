local ls = require 'luasnip'

-- 定义 LuaSnip 片段
ls.snippets = {
	python = {
		-- Python 函数片段
		ls.parser.parse_snippet({ trig = 'def', dscr = 'Define a function' },
			'def ${1:function_name}(${2:args}):\n\t${3:pass}'),
		-- Python For 循环片段
		ls.parser.parse_snippet({ trig = 'for', dscr = 'For loop' }, 'for ${1:item} in ${2:iterable}:\n\t${3:pass}'),
	},
}
