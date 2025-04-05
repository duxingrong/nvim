<center><img src="https://raw.githubusercontent.com/duxingrong/nvim/refs/heads/main/demo.png"></center>

## requirements
> [!NOTE]
> work system is  linux

```bash
sudo apt install python3-pip  git clang-format openssh-server g++ build-essential cmake gdb tmux make xclip
sudo snap install nvim --classic
```

> [!TIP]
> node.js
```bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Download and install Node.js:
nvm install 20

# Verify the Node.js version:
node -v # Should print "v20.18.1".
nvm current # Should print "v20.18.1".

# Verify npm version:
npm -v # Should print "10.8.2".
```
> [!TIP]
> yazi  (please installed by cargo)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
## new terminal window
cargo install --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
```

> [!TIP]
> wezterm
```bash
自动网上下载
```

```pip
pip install pynvim
```

```npm
npm install yarn 
npm -g install instant-markdown-d
```

> [!NOTE]
> please mv config files
```bash
cp -r ~/.config/nvim/yazi ~/.config/
cp -r ~/.config/nvim/wezterm ~/.config/
cp -r ~/.config/nvim/pip ~/.config/
cp ~/.config/nvim/.tmux.conf ~/
```

> [!WARNING]
> 这里如果打开nvim报错找不到lazy,使用下面方法fix
```bash
# 打开nvim，输入
:lua= vim.fn.stdpath("data")
# 记住这个地址
rm -rf 地址
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable /home/du/.local/share/nvim/lazy/lazy.nvim
```



## keymap
| 改键                       | 功能                   |
|----------------------------|------------------------|
| s                          | 没用                   |
| q                          | 没用                   |
| S                          | 保存                   |
| ;                          | :                      |
| kj                         | <ESC>                  |
| J                          | 向下7格                |
| K                          | 向上7格                |
| N                          | 普通模式下光标回到开头 |
| M                          | 普通模式下光标移动行尾 |
| sk                         | 向上分屏               |
| sj                         | 向下分屏               |
| sh                         | 向左分屏               |
| sl                         | 向右分屏               |
| <leader>k                  | 光标向上跳转           |
| <leader>j                  | 光标向下跳转           |
| <leader>h                  | 光标向左跳转           |
| <leader>l                  | 光标向右跳转           |
| <up>,<down>,<left>,<right> | 调整窗口大小           |
| <leader>sc                 | 检查拼写错误           |
| <leader><CR>               | 取消语法高亮           |
| <leader>o                  | 折叠函数               |
| >                          | 向右tab                |
| <                          | 向左tab                |
| KJ                         | 终端模式回到普通模式   |
| <leader>d                  | 关闭诊断               |
| <leader>q                  | 诊断                   |


| 脚本       | 功能                                    |
|------------|-----------------------------------------|
| r          | 运行当前文件                            |
| <leader>ww | 打开wiki,然后<CR>包裹的字体可以创建文件 |
| <leader>p  | markdown下将剪切板图片粘贴到文件中      |


## 插件
| 插件名称                        | 快捷键             | 作用                   |
|---------------------------------|--------------------|------------------------|
| theniceboy/nvim-deus            | None               | 主题                   |
| nvim-pack/nvim-spectre          | F                  | 快速查找和替换         |
| mhinz/vim-startify              | None               | 封面                   |
| nvimtools/none-ls.nvim          | None               | 对齐lua                |
| akinsho/bufferline.nvim         | <tab>              | 跳转标签页             |
| cmp                             | 见cmp.lua          | 自动补全               |
| tomtom/tcomment_vim             | <leader>cm,uc      | 代码注释和反注释       |
| stevearc/conform.nvim           | <leader>f          | 主动格式化python,cpp   |
| folke/flash.nvim                | ss                 | 快速跳转               |
| Eandrju/cellular-automaton.nvim | <leadr>rr          | funny                  |
| gitsigns                        | 见gitsigns.lua     | git相关可视化          |
| lspconfig                       | 见lspconfig.lua    | lsp                    |
| nvim-lualine/lualine.nvim       | None               | 美观状态栏             |
| L3MON4D3/LuaSnip                | 代码快             | 自定义代码块           |
| mg979/vim-visual-multi          | 见multi-cursor.lua | 多光标                 |
| nvim-neo-tree/neo-tree.nvim     | tt or E            | 打开文件管理器neo-tree |
| rcarriga/nvim-notify            | None               | 美化通知栏             |
| airblade/vim-rooter             | None               | 自动更改当前工作目录   |
| folke/snacks.nvim               | zz                 | 开启专注模式           |
| nvim-telescope/telescope.nvim   | telescope.lua      | 模糊查找神器           |
| akinsho/toggleterm.nvim         | : ,T               | 打开终端               |
| nvim-treesitter/nvim-treesitter | None               | 高亮                   |
| mbbill/undotree                 | L                  | 打开历史               |
| folke/which-key.nvim            | None               | 记忆快捷键             |
| gelguy/wilder.nvim              | None               | 补全和美化命令行       |
| mikavilpas/yazi.nvim            | 见yazi.lua         | 文件管理器yazi         |




## Thanks
- [kicamon](https://github.com/Kicamon/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)
- [nvim-lua](https://github.com/nvim-lua/kickstart.nvim) 
- [dotfiles](https://github.com/hendrikmi/dotfiles/tree/main/nvim)
---

### License MIT



