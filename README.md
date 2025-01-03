<center><img src="https://github.com/duxingrong/nvim/main/demo.png"></center>


## requirements
> [!NOTE]
> work system is  linux

```bash
sudo apt install python3-pip  git clang-format openssh-server g++ build-essential cmake gdb tmux make
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
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install  wezterm
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
mv ~/.config/nvim/yazi  ~/.config/
mv ~/.config/nvim/wezterm  ~/.config/
mv ~/.config/nvim/pip  ~/.config/
mv ~/.config/nvim/.tmux.conf ~/
```






