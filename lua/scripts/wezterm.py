"""
setting wezterm background
"""

import os

# 设置 wezterm 配置文件路径
wezterm_config_path = os.path.expanduser("~/.config/wezterm/wezterm.lua")

def toggle_brightness():
    # 读取 wezterm 配置文件
    with open(wezterm_config_path, 'r') as file:
        lines = file.readlines()

    # 查找并修改 brightness 值
    for i, line in enumerate(lines):
        if "window_background_image_hsb" in line and "brightness" in line:
            # 获取当前的 brightness 值
            if "brightness = 0.1" in line:
                lines[i] = line.replace("brightness = 0.1", "brightness = 0")
            elif "brightness = 0" in line:
                lines[i] = line.replace("brightness = 0", "brightness = 0.1")
            break

    # 将修改后的内容写回文件
    with open(wezterm_config_path, 'w') as file:
        file.writelines(lines)


if __name__ == "__main__":
    toggle_brightness()
