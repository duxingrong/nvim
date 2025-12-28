return {
    "mikavilpas/yazi.nvim",       -- 插件名称
    event = "VeryLazy",           -- 触发时机：VeryLazy 表示在启动后较晚加载，不拖慢启动速度
    
    -- 1. Neovim 全局快捷键（在还没打开 Yazi 时使用的按键）
    keys = {
        {
            "R",                  -- 按下 'R' 键
            "<cmd>Yazi<cr>",      -- 执行 :Yazi 命令（打开文件管理器）
            desc = "Open yazi at the current file", --按键描述
        },
    },
    
    -- 2. 插件的具体配置选项
    opts = {
        floating_window_scaling_factor = 0.9,  -- 悬浮窗口缩放比例。1 表示全屏 (100%)，0.5 则是半屏。
        yazi_floating_window_border = "double",-- 悬浮窗边框样式"none","rounded","single","double","solid","shadow"
        open_for_directories = true,         -- 如果在 nvim 打开一个文件夹（如 nvim .），是否自动用 Yazi 代替 Netrw 打开。
        open_multiple_tabs = true,           -- 允许一次选中多个文件并在多个标签页中打开。
        
        -- 3. Yazi 悬浮窗内部的快捷键（只有当 Yazi 窗口打开时才生效）
        keymaps = {
            show_help = '<f1>',              -- 按 F1 显示帮助
            open_file_in_vertical_split = '<c-v>',   -- 按 Ctrl+v：在垂直分屏打开选中文件
            open_file_in_horizontal_split = '<c-x>', -- 按 Ctrl+x：在水平分屏打开选中文件
            open_file_in_tab = '<CR>',      -- 按 Ctrl+t：在【新标签页】打开选中文件
            grep_in_directory = '<c-f>',     -- 按 Ctrl+f：在当前目录进行 Grep 搜索
            copy_relative_path_to_selected_files = '<c-y>', -- 按 Ctrl+y：复制选中文件的相对路径
        },
    },
}
