#!/bin/bash

# 如果任何命令执行失败，则立即退出 
set -e 

# --- 颜色定义 ---
INFO='\033[0;36m'
SUCCESS='\033[0;32m'
ERROR='\033[0;31m'
NC='\033[0m' # No Color

# --- 脚本路径设置 ---
# 获取脚本所在的目录
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DEPS_DIR="$SCRIPT_DIR/dependence"

# --- 辅助函数：向.bashrc添加配置 ---
add_to_bashrc() {
    local line="$1"
    local file="$HOME/.bashrc"
    
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
# 检查是否已安装，避免报错
if ! command -v wezterm &> /dev/null; then
    sudo apt install -y "$DEPS_DIR/wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb"
fi
echo -e "${INFO}--> 正在移动 WezTerm 配置文件...${NC}"
mkdir -p "$HOME/.config"
cp -r "$DEPS_DIR/wezterm" "$HOME/.config/"

# 步骤 2: 安装和配置 Tmux
echo -e "\n${INFO}--> 正在安装 Tmux...${NC}"
sudo apt install -y tmux
echo -e "${INFO}--> 正在移动 Tmux 配置文件...${NC}"
cp "$DEPS_DIR/.tmux.conf" "$HOME/"

# 步骤 3: 安装和配置 Yazi
echo -e "\n${INFO}--> 正在安装 Yazi...${NC}"
mkdir -p "$HOME/.local/bin"

# 定义解压后的文件夹名称，方便后面删除
YAZI_TEMP_DIR="$DEPS_DIR/yazi-x86_64-unknown-linux-musl"

# 解压到 dependence 目录
unzip -o "$DEPS_DIR/yazi-x86_64-unknown-linux-musl.zip" -d "$DEPS_DIR"

# 复制二进制文件 (ya 和 yazi) 到系统目录
echo -e "${INFO}--> 正在安装二进制文件...${NC}"
cp "$YAZI_TEMP_DIR/ya" "$YAZI_TEMP_DIR/yazi" "$HOME/.local/bin/"

# 【关键修改】安装完成后，删除解压出来的临时目录，保持 dependence 干净
echo -e "${INFO}--> 正在清理 Yazi 临时解压文件...${NC}"
rm -rf "$YAZI_TEMP_DIR"

# 配置环境变量
echo -e "${INFO}--> 正在配置 Yazi 的 PATH 和快捷键...${NC}"
add_to_bashrc 'export PATH="$HOME/.local/bin:$PATH"'

# 添加 ra() 函数
RA_FUNC='
function ra() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d "" cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}'
# 这种多行变量写入有时会有问题，这里保持你原有的逻辑，但建议检查写入是否成功
add_to_bashrc "$RA_FUNC"

# 复制 Yazi 的配置文件 (这是你存放在 dependence/yazi 里的配置，不是压缩包里的)
echo -e "${INFO}--> 正在复制 Yazi 配置文件...${NC}"
if [ -d "$DEPS_DIR/yazi" ]; then
    cp -r "$DEPS_DIR/yazi" "$HOME/.config/"
else
    echo -e "${ERROR}警告：未找到 dependence/yazi 配置文件夹${NC}"
fi


# 步骤 4: 安装 Neovim 及其依赖
echo -e "\n${INFO}--> 正在安装 Neovim (snap)...${NC}"
# 检查是否已安装
if ! command -v nvim &> /dev/null; then
    sudo snap install nvim --classic
fi

echo -e "${INFO}--> 正在安装 Python 依赖 (pynvim)...${NC}"
sudo apt install -y python3 python3-pip
pip install pynvim

echo -e "${INFO}--> 正在安装 ripgrep 和 fd...${NC}"
sudo apt install -y ripgrep fd-find
if [ ! -L "$HOME/.local/bin/fd" ]; then
    ln -s "$(which fdfind)" "$HOME/.local/bin/fd"
fi

echo -e "${INFO}--> 正在安装 Node.js...${NC}"
# 检查是否已存在，防止重复移动报错
if [ ! -d "/usr/local/nodejs" ]; then
    tar -xJf "$DEPS_DIR/node-v22.19.0-linux-x64.tar.xz" -C "$DEPS_DIR"
    sudo mv "$DEPS_DIR/node-v22.19.0-linux-x64" /usr/local/nodejs
else
    echo -e "${INFO}Node.js 已存在于 /usr/local/nodejs，跳过安装。${NC}"
fi
add_to_bashrc 'export PATH="/usr/local/nodejs/bin:$PATH"'


# --- 结束 ---
echo -e "\n${SUCCESS}=====================================================${NC}"
echo -e "${SUCCESS}  所有任务已成功完成！🎉${NC}"
echo -e "${SUCCESS}=====================================================${NC}"
echo -e "\n${INFO}请注意：为了让 PATH 和 ra() 函数等环境变量生效，${NC}"
echo -e "${INFO}请执行以下命令，或完全关闭并重新打开你的终端：${NC}"
echo -e "\n    ${SUCCESS}source ~/.bashrc${NC}\n"
echo -e "\n    ${SUCCESS}请手动安装 cargo (Rust):${NC}"
echo -e "    ${SUCCESS}curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh${NC}\n"
