# 🚀 Neovim 配置文档

一个现代化的 Neovim 配置，专注于提供优雅的编辑体验和强大的开发环境。

## ✨ 特性

- 🎨 美观的 UI 和配色方案
- 🔍 智能的代码补全
- 🛠 强大的 LSP 支持
- 📝 自动代码格式化
- 🌲 集成文件树
- 🔎 模糊查找
- ⚡️ 快速启动
- 🎮 直观的快捷键

## 📁 目录结构

```
.
├── 📄 init.lua              # 主配置文件
├── 📋 lazy-lock.json       # 插件版本锁定文件
└── 📁 lua/
    ├── 📁 core/           # 核心配置
    │   ├── 📄 options.lua  # 基础选项
    │   └── 📄 keymaps.lua  # 快捷键映射
    └── 📁 plugins/        # 插件配置
        ├── 📄 ui.lua       # UI 相关插件
        ├── 📄 lsp.lua      # LSP 配置
        ├── 📄 completion.lua # 补全配置
        └── 📄 utils.lua    # 工具插件
```

## 🔌 插件系统

### 核心插件

1. **UI 增强**
   - `tokyonight.nvim`: 现代化主题
   - `lualine.nvim`: 状态栏美化
   - `nvim-tree.lua`: 文件浏览器
   - `dashboard-nvim`: 启动界面
   - `indent-blankline.nvim`: 缩进指示线

2. **编辑增强**
   - `nvim-autopairs`: 自动括号配对
   - `Comment.nvim`: 智能注释
   - `nvim-surround`: 包围修改
   - `flash.nvim`: 快速跳转

3. **开发工具**
   - `mason.nvim`: LSP 管理器
   - `nvim-lspconfig`: LSP 配置
   - `nvim-cmp`: 代码补全
   - `conform.nvim`: 代码格式化
   - `gitsigns.nvim`: Git 集成

## ⌨️ 快捷键

### 基础操作
- `Space`: Leader 键
- `S`: 保存文件
- `kj`: 退出插入模式
- `Q`: 关闭缓冲区/退出

### 窗口管理
- `<Leader>h/j/k/l`: 窗口导航
- `s + h/j/k/l`: 窗口分割
- 方向键: 调整窗口大小

### 代码导航
- `gd`: 转到定义
- `gr`: 查看引用
- `K`: 显示文档
- `[d/]d`: 上/下一个诊断

### 代码编辑
- `<Leader>ca`: 代码操作
- `<Leader>rn`: 重命名
- `<Leader>f`: 格式化
- `gc`: 注释

### 文件操作
- `<Leader>e`: 文件树
- `<Leader>ff`: 查找文件
- `<Leader>fg`: 全文搜索
- `<Leader>fb`: 缓冲区列表

## 🛠 安装说明

### 前置要求

- Neovim >= 0.8.0
- Git
- 一个 [Nerd Font](https://www.nerdfonts.com/) 字体
- ripgrep (用于全文搜索)

## 🎨 个性化配置

### 更改主题

```lua
-- 在 lua/plugins/ui.lua 中修改
require("tokyonight").setup({
    style = "storm", -- 可选: night, storm, day, moon
})
```

### 添加 LSP 服务器

```lua
-- 在 lua/plugins/lsp.lua 中取消注释相应配置
lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
```

### 配置格式化工具

```lua
-- 在 lua/plugins/formatting.lua 中取消注释相应配置
formatters_by_ft = {
    python = { "black" },
    lua = { "stylua" },
}
```

windows安装gcc
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop install gcc
```

## 📝 使用技巧

1. **高效编辑**
   - 使用 `gc` 快速注释
   - 使用 `s` 进行快速跳转
   - 使用 `<Leader>f` 格式化代码

2. **文件管理**
   - 使用 `<Leader>e` 打开文件树
   - 使用 `<Leader>ff` 快速查找文件
   - 使用 `<Leader>fg` 全文搜索

3. **代码导航**
   - 使用 `gd` 跳转到定义
   - 使用 `gr` 查看引用
   - 使用 `gh` 查看文档

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📜 许可

MIT License

## 🙏 鸣谢

感谢以下项目：
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [以及所有使用的插件](#核心插件)

---

💫 享受编码的乐趣！ 