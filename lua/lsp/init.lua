-- 为 nvim-cmp 配置 LSP 功能
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 为所有 LSP 服务器设置默认功能
vim.lsp.config('*', {
    capabilities = capabilities,
})

-- 配置诊断（错误、警告等）的显示方式
vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»"
        },
    },
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "none",
        source = "if_many",
        header = "",
        prefix = "",
    },
})

-- 设置自动命令：当光标悬停时显示诊断信息
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float({
            focusable = false,
            close_events = {
                "BufLeave",
                "CursorMoved",
                "InsertEnter",
                "FocusLost"
            },
            border = "none",
            source = "if_many",
            prefix = "",
        })
    end
})

-- 设置 LspAttach 自动命令，用于加载每个缓冲区的配置
local autocomplete_configured = false
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- 仅当 LSP 附加到缓冲区时，才配置一次自动补全
        if not autocomplete_configured then
            local ok, err = pcall(require("plugins.autocomplete").configfunc)
            if ok then
                autocomplete_configured = true
            else
                vim.notify("配置自动补全失败: " .. tostring(err), vim.log.levels.ERROR)
            end
        end

        -- 为每个缓冲区设置 LSP 快捷键
        local ok, err = pcall(require('lsp.keymaps').setup, event.buf)
        if not ok then
            vim.notify("设置 LSP 快捷键失败: " .. tostring(err), vim.log.levels.WARN)
        end
    end
})

-- 加载您需要的语言服务器配置
require('lsp.servers.lua').setup()
require('lsp.servers.python').setup()
-- 新增：加载包含 clangd 的服务器配置
require('lsp.servers.misc').setup()

-- 设置 Mason，用于管理 LSP 服务器
require('mason').setup({})
require('mason-lspconfig').setup({
    -- 确保安装 Lua, Python 和 clangd 的 LSP 服务器
    ensure_installed = {
        "lua_ls",
        'pyright',
        'clangd', 
    },
    automatic_installation = true,
})

-- 设置保存时自动格式化的文件类型
local format_on_save_filetypes = {
    lua = true,
    python = true,
    c = true,      -- 新增 C
	cpp = true,    -- 新增 C++
	objc = true,   -- 新增 Objective-C
	objcpp = true, -- 新增 Objective-C++
}

-- 创建自动命令，在保存前进行格式化
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if format_on_save_filetypes[vim.bo.filetype] then
            local lineno = vim.api.nvim_win_get_cursor(0)
            vim.lsp.buf.format({ async = false })
            pcall(vim.api.nvim_win_set_cursor, 0, lineno)
        end
    end,
})
