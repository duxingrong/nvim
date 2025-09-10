#!/bin/bash

# 如果任何命令执行失败，则立即退出 
set -e 

# --- 颜色定义 ---
INFO='\033[0;36m'
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
NC='\033[0m' # No Color


# --- 脚本路径设置 ---
# 获取脚本所在的目录，确保我们能找到'dependence'文件夹
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DEPS_DIR="$SCRIPT_DIR/dependence"

# --- 辅助函数：向.bashrc添加配置，避免重复 ---
add_to_bashrc() {
    local line="$1"
    local file="$HOME/.bashrc"
    
    # 检查配置是否已存在
    if ! grep -qF -- "$line" "$file"; then
        echo -e "\n$line" >> "$file"
        echo -e "${INFO}已将配置添加到 $file${NC}"
    else
        echo -e "${INFO}配置已存在于 $file，跳过添加。${NC}"
    fi
}


# --- 主程序 ---
echo -e "${INFO}=== 开始自动化配置环境 ===${NC}"

# 步骤 0: 刷新 apt 列表
echo -e "\n${INFO}--> 正在更新 apt 软件包列表...${NC}"
sudo apt update

# 步骤 1: 安装和配置 WezTerm
echo -e "\n${INFO}--> 正在安装 WezTerm...${NC}"
sudo apt install -y "$DEPS_DIR/wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb"
echo -e "${INFO}--> 正在移动 WezTerm 配置文件...${NC}"
# 确保目标目录存在
mkdir -p "$HOME/.config"
mv "$DEPS_DIR/wezterm" "$HOME/.config/"

# 步骤 2: 安装和配置 Tmux
echo -e "\n${INFO}--> 正在安装 Tmux...${NC}"
sudo apt install -y tmux
echo -e "${INFO}--> 正在移动 Tmux 配置文件...${NC}"
mv "$DEPS_DIR/.tmux.conf" "$HOME/"

# 步骤 3: 安装和配置 Yazi
echo -e "\n${INFO}--> 正在安装 Yazi...${NC}"
# 确保 ~/.local/bin 存在
mkdir -p "$HOME/.local/bin"
unzip -o "$DEPS_DIR/yazi-x86_64-unknown-linux-musl.zip" -d "$DEPS_DIR"
mv "$DEPS_DIR/yazi-x86_64-unknown-linux-musl/ya" "$DEPS_DIR/yazi-x86_64-unknown-linux-musl/yazi"  "$HOME/.local/bin/"
echo -e "${INFO}--> 正在配置 Yazi 的 PATH 和快捷键...${NC}"
add_to_bashrc 'export PATH="$HOME/.local/bin:$PATH"'

# 添加 ra() 函数到 .bashrc，使用heredoc防止重复
RA_FUNC='
function ra() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d "" cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}'
add_to_bashrc "$RA_FUNC"

# 步骤 4: 安装 Neovim 及其依赖
echo -e "\n${INFO}--> 正在安装 Neovim (snap)...${NC}"
sudo snap install nvim --classic

echo -e "${INFO}--> 正在安装 Python 依赖 (pynvim)...${NC}"
sudo apt install -y python3 python3-pip
pip install pynvim

echo -e "${INFO}--> 正在安装 ripgrep 和 fd...${NC}"
sudo apt install -y ripgrep fd-find
# 确保软链接不重复创建
if [ ! -L "$HOME/.local/bin/fd" ]; then
    ln -s "$(which fdfind)" "$HOME/.local/bin/fd"
fi

echo -e "${INFO}--> 正在安装 Node.js...${NC}"
tar -xJf "$DEPS_DIR/node-v22.19.0-linux-x64.tar.xz" -C "$DEPS_DIR"
# 如果已存在，先删除，防止mv失败
if [ -d "/usr/local/nodejs" ]; then
    sudo rm -rf "/usr/local/nodejs"
fi
sudo mv "$DEPS_DIR/node-v22.19.0-linux-x64" /usr/local/nodejs
add_to_bashrc 'export PATH="/usr/local/nodejs/bin:$PATH"'

# 步骤 5: 安装 Google Chrome
echo -e "\n${INFO}--> 正在安装 Google Chrome...${NC}"
sudo apt install -y "$DEPS_DIR/google-chrome-stable_current_amd64.deb"

# 步骤 6: 安装 Clash Verge
echo -e "\n${INFO}--> 正在安装 Clash Verge...${NC}"
sudo apt install -y "$DEPS_DIR/Clash.Verge_2.4.1_amd64.deb"

# --- 结束 ---
echo -e "\n${SUCCESS}=====================================================${NC}"
echo -e "${SUCCESS}  所有任务已成功完成！🎉${NC}"
echo -e "${SUCCESS}=====================================================${NC}"
echo -e "\n${INFO}请注意：为了让 PATH 和 ra() 函数等环境变量生效，${NC}"
echo -e "${INFO}请执行以下命令，或完全关闭并重新打开你的终端：${NC}"
echo -e "\n    ${SUCCESS}source ~/.bashrc${NC}\n"

