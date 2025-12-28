return {
    'gelguy/wilder.nvim',
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- 依赖图标库，这样命令旁边可以显示好看的图标
    },
    config = function()
        local wilder = require('wilder')

        -- 1. 基础启动配置
        wilder.setup {
            -- 指定 wilder 在哪些模式下生效
            -- ':' 表示仅在命令模式（按下 : 时）生效
            -- 如果你想在搜索模式（按下 / 或 ? 时）也生效，可以写成 { ':', '/', '?' }
            modes = { ':' },

            -- 设置在下拉菜单中选择下一个/上一个候选项的快捷键
            next_key = '<Tab>',      -- 按 Tab 选择下一个
            previous_key = '<S-Tab>', -- 按 Shift+Tab 选择上一个
        }

        -- 2. 设置渲染器（Renderer），决定菜单长什么样
        wilder.set_option('renderer', wilder.popupmenu_renderer(
            -- 使用 'palette_theme' (调色板主题)
            -- 这种主题会让菜单像一个悬浮在屏幕中间（或顶部）的弹窗，而不是挤在最下面
            wilder.popupmenu_palette_theme({
                highlights = {
                    border = 'Normal', -- 边框的颜色高亮组，这里使用 Normal 组的颜色
                },
                -- 左侧显示的组件：[空格, 图标]
                left = { ' ', wilder.popupmenu_devicons() },
                -- 右侧显示的组件：[空格, 滚动条]
                right = { ' ', wilder.popupmenu_scrollbar() },
                
                border = 'rounded',      -- 边框样式：圆角 (也可以选 'single', 'double' 等)
                max_height = '75%',      -- 弹窗的最大高度，占屏幕高度的 75%
                min_height = 0,          -- 最小高度 (设为 0 表示自适应内容高度)
                prompt_position = 'top', -- 命令输入框的位置：'top' (顶部) 或 'bottom' (底部)
                reverse = 0,             -- 是否反转列表顺序 (0 不反转)。如果 prompt 在底部，通常设为 1 让列表向上延伸
            })
        ))

        -- 3. 设置流水线（Pipeline），决定如何查找补全内容
        wilder.set_option('pipeline', {
            wilder.branch(
                -- 分支 1：命令行命令的补全
                wilder.cmdline_pipeline({
                    language = 'vim', -- 语言环境
                    fuzzy = 1,        -- 打开模糊搜索 (重要！)
                                      -- 比如你想输 "vertical split"，只需输 "vsp" 就能匹配到
                }),
                -- 分支 2：搜索模式的补全 (虽然你上面 modes 只开了 ':', 但配置这个是为了防备你以后开启搜索模式)
                wilder.search_pipeline()
            ),
        })
    end
}
