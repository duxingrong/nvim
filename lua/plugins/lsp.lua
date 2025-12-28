return {
	-- part 1: Mason 独立配置
	-- 这样配置后，无论是否打开文件，输入 :Mason 都能自动加载
	{
		"williamboman/mason.nvim",
		cmd = "Mason", -- 当输入 :Mason 命令时触发加载
		keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } }, -- 绑定个快捷键(可选)
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- part 2: LSP 配置
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"Saghen/blink.cmp",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- 1. 初始化 mason-lspconfig (Mason 本体已经在上面配置了，这里不用再 setup)
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
				},
				automatic_installation = true,
			})

			-- 2. 定义 LSP 服务器配置
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
			}

			-- 3. 自动配置 LSP 并注入 blink.cmp 的能力
			local lspconfig = require("lspconfig")
			local blink = require("blink.cmp")

			require("mason-lspconfig").setup({
				-- 确保安装列表
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
				},
				automatic_installation = true,

				handlers = {
					function(server_name)
						-- 获取上面定义的配置，如果没有定义则为空表
						local config = servers[server_name] or {}

						-- 注入 blink.cmp 的 capabilities
						config.capabilities = blink.get_lsp_capabilities(config.capabilities)

						-- 启动 LSP
						lspconfig[server_name].setup(config)
					end,
				},
			})
		end,
	},
}
