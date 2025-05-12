--[[
  init.lua - Neovim 主配置文件
  
  这是整个配置的入口文件，主要完成以下任务：
  1. 设置基础键位映射（Leader 键）
  2. 初始化 lazy.nvim 插件管理器
  3. 加载其他核心配置模块

  使用的插件：
  - lazy.nvim: 现代化的插件管理器
    - 特点：懒加载机制、自动更新、性能优化
    - 地址：https://github.com/folke/lazy.nvim
--]]

-- nvim/init.lua

-- 设置 Leader 键 (全局和局部)
-- 注意: 在 options.lua 中也会设置，这里确保在插件加载前生效
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 加载核心配置
require("core.options")
require("core.keymaps")

-- 设置 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载 lazy.nvim 并指定插件配置目录
require("lazy").setup("plugins", {
  -- lazy.nvim 的配置选项 (可选)
  checker = {
    enabled = true, -- 检查插件更新
    notify = false, -- 不自动弹出通知
  },
  change_detection = {
    notify = false, -- 不自动弹出检测到更改的通知
  },
})

-- print("Neovim configured with lazy.nvim!")