# dotfile

## 以下操作步骤为ubuntu22.04

```bash
cd ~/.config/
git clone git@github.com/duxingrong/nvim.git # ssh 
git clone https://github.com/duxingrong/nvim.git # https
```

## 终端wezterm配置

```bash
cd ~/.config/nvim/dependence/
sudo dpkg -i wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
# 移动配置文件
mv ~/.config/nvim/dependence/wezterm/ ~/.config
```

## 安装tmux 

```bash
sudo apt install tmux 
# 将配置文件移动到正确位置
mv ~/.config/nvim/dependence/.tmux.conf ~/
```

## 安装yazi


```bash
cd ~/.config/nvim/dependence/
unzip yazi-x86_64-unknown-linux-musl.zip
mv ya yazi ~/.local/bin/
echo 'export PATH=/home/du/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
rm -rf ~/.config/nvim/dependence/yazi-x86_64-unknown-linux-musl
```

修改yazi启动快捷按键

```bash
function ra() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
```

## 安装nvim
```bash
sudo snap install nvim --classic

# 安装pynvim
sudo apt install python3
sudo apt install python3-pip
pip install pynvim # Ultisnips依赖

# 安装ripgrep
sudo apt update
sudo apt install ripgrep

sudo apt install fd-find
ln -s $(which fdfind) ~/.local/bin/fd # 确保~/.local/bin在$PATH中

# 安装node.js
cd ~/.config/nvim/dependence/
tar -xJf node-v22.19.0-linux-x64.tar.xz
sudo mv node-v22.19.0-linux-x64 /usr/local/nodejs
echo 'export PATH=/usr/local/nodejs/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
## 验证
node -v 
npm -v
```

## 安裝google
```bash
cd .config/nvim/dependence/
sudo apt install ./google-chrome-stable_current_amd64.deb
```
## 安裝clash
```bash
cd .config/nvim/dependence/
sudo apt install ./Clash.Verge_2.4.1_amd64.deb
```























