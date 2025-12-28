return {
    "nvim-lualine/lualine.nvim",
    event = "UiEnter",

    config = function()

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto', 
                -- 使用更酷炫的分隔符
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true, -- 建议保持 true，这样看起来更整体
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            
            sections = {
                -- 【左侧 A 区】：通常放“模式”，颜色最显眼
                lualine_a = { 
                    {
                        'mode',
                        -- formatting: 让模式显示得更简洁，比如 "NORMAL"
                        fmt = function(str) return str end 
                        -- 如果你想显示图标，lualine 默认会自动根据 mode 变色
                    }
                },
                
                -- 【左侧 B 区】：版本控制信息
                lualine_b = { 
                    'branch', 
                    'diff', 
                    {
                        'diagnostics',
                        -- 自定义诊断图标
                        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}


                    } 
                },
                
                -- 【左侧 C 区】：文件名和搜索信息
                lualine_c = { 
                    {
                        'filename',
                        file_status = true, -- 显示只读/修改状态
                        path = 1,           -- 1 = 显示相对路径 (src/main.js)，0 = 仅文件名
                        symbols = {
                            modified = '[+]',      -- 文件被修改时的标记
                            readonly = '[-]',      -- 只读文件的标记
                            unnamed = '[No Name]', -- 无名 buffer
                            newfile = '[New]',     -- 新文件
                        }
                    }
                },
                
                -- 【右侧 X 区】：原本是空的，现在放入 LSP 状态和文件编码
                lualine_x = {
                    {
                        -- 搜索结果计数：当你按 / 搜索时显示 [1/12]
                        'searchcount',
                        maxcount = 999,
                        timeout = 500,
                    },
                    {
                        -- 选中统计：Visual 模式下显示选中了多少行/字
                        'selectioncount'
                    },
                    'encoding',   -- 文件编码 (utf-8)
                    'fileformat', -- 系统格式 (unix)
                    'filetype'    -- 文件类型图标
                },
                
                -- 【右侧 Y 区】：进度
                lualine_y = { 'progress' }, -- 显示百分比 (Top/Bot/50%)
                
                -- 【右侧 Z 区】：位置
                lualine_z = { 'location' }  -- 行号:列号
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end
}
