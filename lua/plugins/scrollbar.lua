return {
    "petertriho/nvim-scrollbar", -- 插件名字
    dependencies = {
        "kevinhwang91/nvim-hlslens", -- 依赖插件，用于增强搜索高亮功能
    },
    config = function()
        -- 1. 自定义 Git 状态在滚动条上的颜色
        -- 创建一个自动命令组，防止重复定义
        local group = vim.api.nvim_create_augroup("scrollbar_set_git_colors", {})
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = function()
                -- 这里设置具体的颜色值 (Green/Yellow/Red)
                vim.cmd([[
                    hi! ScrollbarGitAdd guifg=#8CC85F
                    hi! ScrollbarGitAddHandle guifg=#A0CF5D
                    hi! ScrollbarGitChange guifg=#E6B450
                    hi! ScrollbarGitChangeHandle guifg=#F0C454
                    hi! ScrollbarGitDelete guifg=#F87070
                    hi! ScrollbarGitDeleteHandle guifg=#FF7B7B 
                ]])
            end,
            group = group,
        })

        -- 2. 初始化各个模块
        require("scrollbar.handlers.search").setup({})   -- 启用搜索高亮支持
        require("scrollbar.handlers.gitsigns").setup()   -- 启用 Git 符号支持

        -- 3. 核心配置
        require("scrollbar").setup({
            show = true, -- 开启滚动条
            handle = {
                text = " ",        -- 滚动滑块的样式（这里用空格配合背景色实现方块效果）
                color = "#928374", -- 滑块颜色
                hide_if_all_visible = true, -- 如果文件没超过一屏，就不显示滚动条
            },
            marks = {
                Search = { color = "yellow" }, -- 搜索结果在滚动条上显示为黄色
                Misc = { color = "purple" },   -- 其他标记显示为紫色
            },
            handlers = {
                cursor = false,     -- 不在滚动条上单独显示光标位置线（因为有滑块了）
                diagnostic = true,  -- 显示代码错误/警告标记
                gitsigns = true,    -- 显示 Git 修改标记
                handle = true,      -- 显示滑块本身
                search = true,      -- 显示搜索结果标记
            },
        })
    end,
}

