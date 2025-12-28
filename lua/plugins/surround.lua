return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
	end
}


-- 1. 修改包围物 (c = change)
--
-- 快捷键：cs (Change Surround)
--
--     场景：把双引号变成单引号。
--
--     原文："Hello world"
--
--     操作：按下 cs"' (意思是：Change Surround " to ')
--
--     结果：'Hello world'
--
--     场景：把方括号变成圆括号。
--
--     原文：[Hello world]
--
--     操作：按下 cs])
--
--     结果：(Hello world)
--
-- 2. 删除包围物 (d = delete)
--
-- 快捷键：ds (Delete Surround)
--
--     场景：删掉单词两边的双引号。
--
--     原文："Hello world"
--
--     操作：按下 ds" (意思是：Delete Surround ")
--
--     结果：Hello world
--
--     场景：删掉外面的大括号。
--
--     原文：{ print("hi") }
--
--     操作：按下 ds{
--
--     结果：print("hi")
--
-- 3. 添加包围物 (y = you / yank)
--
-- 快捷键：ys (You Surround - 这里的 y 稍微有点抽象，你可以理解为 "Add")
--
--     场景：给当前单词加上双引号。
--
--     原文：Hello (光标在单词上)
--
--     操作：按下 ysiw" (意思是：You Surround Inner Word with ")
--
--     结果："Hello"
--
--     场景：给整行加上括号。
--
--     原文：print("hi")
--
--     操作：按下 yss) (给整行加)
--
--     结果：(print("hi"))
