# 🚀 我的 Neovim 配置

<div align="center">
    <img src="https://raw.githubusercontent.com/duxingrong/nvim/refs/heads/main/demo.png" alt="Neovim 配置演示">
    <p>✨ 一个注重开发效率和用户体验的现代化 Neovim 配置 ✨</p>
</div>

<div align="center">

![Lua](https://img.shields.io/badge/使用-Lua-blue?style=for-the-badge&logo=lua)
![Neovim](https://img.shields.io/badge/适用于-Neovim-green?style=for-the-badge&logo=neovim)
![License](https://img.shields.io/badge/许可证-MIT-yellow?style=for-the-badge)

</div>

## 📋 目录

- [特性](#-特性)
- [环境要求](#-环境要求)
- [安装说明](#-安装说明)
- [按键映射](#-按键映射)
- [插件列表](#-插件列表)
- [截图展示](#-截图展示)
- [致谢](#-致谢)

## ✨ 特性

- 🎨 精美简洁的用户界面与自定义主题
- 🔍 使用 Telescope 实现强大的模糊查找
- 🌳 使用 Neo-tree 的文件浏览器
- ⚡ 快速启动时间
- 📝 智能代码补全
- 🔧 内置终端支持
- 🎯 Git 集成
- 🚀 多语言 LSP 支持
- 📦 使用 Lazy.nvim 高效管理插件

## 🛠 环境要求

### 系统要求

> [!NOTE]
> 此配置主要在 Linux 系统上测试。

```bash
# 安装必要的包
sudo apt install python3-pip git clang-format openssh-server g++ build-essential cmake gdb tmux make xclip

# 安装 Neovim
sudo snap install nvim --classic
```

### Node.js 安装
```bash
# 安装 nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# 安装 Node.js
nvm install 20

# 验证安装
node -v  # 应显示 v20.18.1
npm -v   # 应显示 10.8.2
```

### 其他依赖

```bash
# 安装 Yazi 文件管理器
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli

# Python 依赖
pip install pynvim

# Node.js 依赖
npm install yarn 
npm -g install instant-markdown-d
```

## 🚀 安装说明

1. 克隆此仓库：
```bash
git clone https://github.com/duxingrong/nvim.git ~/.config/nvim
```

2. 复制配置文件：
```bash
cp -r ~/.config/nvim/yazi ~/.config/
cp -r ~/.config/nvim/wezterm ~/.config/
cp -r ~/.config/nvim/pip ~/.config/
cp ~/.config/nvim/.tmux.conf ~/
```

> [!WARNING]
> 如果遇到 Lazy.nvim 错误，请使用以下方法修复：
```bash
# 在 Neovim 中运行：
:lua= vim.fn.stdpath("data")
# 删除数据目录
rm -rf <data_path>
# 重新安装 Lazy.nvim
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
```

## ⌨️ 按键映射

### 基本映射

| 按键                       | 功能                             |
|---------------------------|----------------------------------|
| `S`                       | 保存文件                         |
| `;`                       | 进入命令模式                     |
| `kj`                      | 退出插入模式                     |
| `J`                       | 向下移动 7 行                    |
| `K`                       | 向上移动 7 行                    |
| `N`                       | 跳转到行首                       |
| `M`                       | 跳转到行尾                       |

### 窗口管理

| 按键                       | 功能                             |
|---------------------------|----------------------------------|
| `sk`                      | 向上分屏                         |
| `sj`                      | 向下分屏                         |
| `sh`                      | 向左分屏                         |
| `sl`                      | 向右分屏                         |
| `<leader>k/j/h/l`         | 在窗口间导航                     |
| 方向键                    | 调整窗口大小                     |

### 功能键

| 按键                       | 功能                             |
|---------------------------|----------------------------------|
| `<leader>sc`              | 切换拼写检查                     |
| `<leader><CR>`            | 清除搜索高亮                     |
| `<leader>o`               | 切换函数折叠                     |
| `>/< `                    | 缩进/反缩进                      |
| `<leader>d`               | 切换诊断信息                     |
| `<leader>q`               | 打开诊断窗口                     |

### 代码片段

| 按键                       | 功能                             |
|---------------------------|----------------------------------|
| `<C-e>`                   | 展开代码片段                     |
| `<C-j>`                   | 跳转到下一个光标位置             |
| `<C-k>`                   | 跳转到上一个光标位置             |

### 特殊功能

| 按键                       | 功能                             |
|---------------------------|----------------------------------|
| `r`                       | 运行当前文件                     |
| `<leader>ww`              | 打开维基                         |
| `<leader>p`               | 在 Markdown 中粘贴剪贴板图片     |

## 🔌 插件列表

### 界面和主题
| 插件名称                    | 快捷键            | 描述                    |
|----------------------------|------------------|------------------------|
| theniceboy/nvim-deus      | -                | 配色方案               |
| nvim-lualine/lualine.nvim | -                | 状态栏                 |
| mhinz/vim-startify        | -                | 启动界面               |

### 文件管理
| 插件名称                    | 快捷键            | 描述                    |
|----------------------------|------------------|------------------------|
| nvim-neo-tree/neo-tree.nvim| `tt` 或 `E`      | 文件浏览器             |
| mikavilpas/yazi.nvim      | 见 yazi.lua      | 文件管理器             |
| nvim-telescope/telescope.nvim| 见 telescope.lua| 模糊查找器             |

### 编辑和代码
| 插件名称                    | 快捷键            | 描述                    |
|----------------------------|------------------|------------------------|
| tomtom/tcomment_vim       | `<leader>cm,uc`  | 代码注释               |
| stevearc/conform.nvim     | `<leader>f`      | 代码格式化             |
| folke/flash.nvim          | `ss`             | 快速跳转               |
| mg979/vim-visual-multi    | 见 multi-cursor   | 多光标编辑             |

### 开发工具
| 插件名称                    | 快捷键            | 描述                    |
|----------------------------|------------------|------------------------|
| nvimtools/none-ls.nvim    | -                | 额外的 LSP 功能        |
| gitsigns                  | 见 gitsigns.lua   | Git 集成              |
| akinsho/toggleterm.nvim   | `:`, `T`         | 终端集成              |

## 📸 截图展示

[在此添加你的截图]

## 🙏 致谢

特别感谢：
- [kicamon](https://github.com/Kicamon/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)
- [nvim-lua](https://github.com/nvim-lua/kickstart.nvim)
- [dotfiles](https://github.com/hendrikmi/dotfiles/tree/main/nvim)

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

---

<div align="center">
    <p>由 duxingrong 用 ❤️ 制作</p>
</div>
