return {
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('hlchunk').setup({
                -- 1. 这是光标所在代码块的高亮
                chunk = {
                    enable = true,
                    use_treesitter = true,
                    style = {
                        { fg = "#806d9c" }, -- 还是保持你喜欢的紫色高亮
                    },
                },
                
                -- 2. 这是普通的缩进线（你需要修改这里！）
                indent = {
                    enable = true,
                    chars = {  "¦", "┆", "┊" },
                    use_treesitter = false,
                    
                    -- 【关键修改在这里】设置普通缩进线的颜色
                    style = {
                        { fg = "#606570" }, 
                    },
                },
                
                blank = { enable = false },
                line_num = { use_treesitter = true },
            })
        end
    },
}
