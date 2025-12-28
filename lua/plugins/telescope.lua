local m = { noremap = true, nowait = true } -- 定义常用的按键映射参数：不递归映射，不等待

return {
    -- =========================================================================
    -- 核心插件：Telescope (模糊搜索神器)
    -- =========================================================================
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- 图标支持，让搜索结果带有文件类型图标
            "nvim-lua/plenary.nvim",       -- 很多 Lua 插件的基础依赖库
            
            -- -- [子插件 1] 标签页管理
            -- {
            --     "LukasPietzschmann/telescope-tabs",
            --     config = function()
            --         local tstabs = require('telescope-tabs')
            --         tstabs.setup({})
            --         -- 快捷键 Ctrl+t：打开一个 Telescope 窗口，列出所有 Tab，回车切换
            --         vim.keymap.set('n', '<c-t>', tstabs.list_tabs, {})
            --     end
            -- },
            
            -- [子插件 2] FZF 核心算法库 (C语言编译，极速排序)
            -- 必须运行 make 编译，提供高性能的模糊匹配算法
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            
            -- [子插件 3] UI 美化
            -- 让 vim.ui.select 和 vim.ui.input (如重命名、代码行为) 使用更好看的弹窗
            'stevearc/dressing.nvim',
        },
        
        config = function()
            local builtin = require('telescope.builtin')

            -- 1. 全局搜索快捷键设置
            -- -----------------------------------------------------------------
            vim.keymap.set('n', '<c-f>', builtin.find_files, m) -- Ctrl+f: 查找文件名
            vim.keymap.set('n', '<leader>rs', builtin.resume, m) -- <Leader>rs: 恢复上一次的搜索窗口 (非常有用)
            vim.keymap.set('n', '<c-t>', builtin.buffers, m)    -- Ctrl+t: 列出当前打开的缓冲区(Buffer)并切换
            vim.keymap.set('n', '<c-h>', builtin.oldfiles, m)   -- Ctrl+h: 查找最近打开过的历史文件
            vim.keymap.set('n', '<c-i>', builtin.current_buffer_fuzzy_find, m) -- Ctrl+i 在当前文件内容中模糊搜索

            -- 查看诊断信息 (Diagnostics)，按严重程度排序
            vim.keymap.set('n', '<leader>d', function()
                builtin.diagnostics({
                    sort_by = "severity"
                })
            end, m)

            -- 2. 手动定义诊断等级常量 (这部分在较新版本的 Neovim 可能不需要，属于补全定义)
            -- -----------------------------------------------------------------
            vim.lsp.protocol.DiagnosticSeverity = {
                "Error", "Warning", "Information", "Hint",
                Error = 1, Hint = 4, Information = 3, Warning = 2
            }
            vim.diagnostic.severity = {
                "ERROR", "WARN", "INFO", "HINT",
                E = 1, ERROR = 1, HINT = 4, I = 3, INFO = 3, N = 4, W = 2, WARN = 2
            }

            -- 更多快捷键
            vim.keymap.set('n', 'gi', builtin.git_status, m) -- gi: 查看 Git 修改状态 (Diff)
            -- vim.keymap.set("n", ":", builtin.commands, m)    -- :: 列出并搜索 Neovim 命令

            -- 3. Telescope 核心配置
            -- -----------------------------------------------------------------
            local ts = require('telescope')
            local actions = require('telescope.actions')
            
            ts.setup({
                defaults = {
                    -- 搜索时忽略的文件或目录模式
                    file_ignore_patterns = {
                        "node_modules", "build", "dist", "%.pub%-cache",
                    },
                    -- 配置 grep (搜索内容) 的命令行参数 (使用的是 ripgrep / rg)
                    vimgrep_arguments = {
                        "rg", "--color=never", "--no-heading", "--with-filename",
                        "--line-number", "--column", "--fixed-strings", "--smart-case", "--trim",
                    },
                    -- 窗口布局配置：宽高都占屏幕的 90%
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
                    },
                    -- 窗口内的按键映射 (Insert 模式下)
                    mappings = {
                        i = {
                            ["<F1>"] = "which_key",               -- F1: 显示按键帮助
                            ["<C-k>"] = "move_selection_previous",-- Ctrl+k: 上移选择
                            ["<C-j>"] = "move_selection_next",    -- Ctrl+j: 下移选择
                            ["<C-l>"] = "preview_scrolling_up",   -- Ctrl+l: 预览窗口向上滚动
                            ["<C-h>"] = "preview_scrolling_down", -- Ctrl+h: 预览窗口向下滚动
                            ["<esc>"] = "close",                  -- ESC: 关闭窗口
                            ["<C-n>"] = require('telescope.actions').cycle_history_next, -- Ctrl+n: 下一条历史搜索记录
                            ["<C-p>"] = require('telescope.actions').cycle_history_prev, -- Ctrl+p: 上一条历史搜索记录
                        }
                    },
                    color_devicons = true, -- 启用彩色图标
                    prompt_prefix = "🔍 ", -- 输入框前的图标
                    selection_caret = " ",-- 选中项前的图标
                    path_display = { "truncate" }, -- 路径过长时截断显示
                    -- 配置默认预览器 (通常不需要动)
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                },
                
                -- 扩展插件配置
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- 开启模糊匹配
                        override_generic_sorter = true, -- 覆盖默认排序器
                        override_file_sorter = true,    -- 覆盖文件排序器
                        case_mode = "smart_case",       -- 智能大小写 (全小写忽略大小写，含大写则精确匹配)
                    },
                }
            })

            -- 4. 配置 Dressing (UI 美化)
            -- -----------------------------------------------------------------
            require('dressing').setup({
                select = {
                    get_config = function(opts)
                        -- 如果是代码行为 (Code Action)，使用光标处的小弹窗主题，而不是全屏弹窗
                        if opts.kind == 'codeaction' then
                            return {
                                backend = 'telescope',
                                telescope = require('telescope.themes').get_cursor()
                            }
                        end
                    end
                }
            })

        end
    },
}
