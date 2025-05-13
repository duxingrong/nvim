return {
	{
		'williamboman/mason.nvim',
		opts = {
			ensure_installed = {
				'lua-language-server',
				'pyright', -- 添加 Python LSP (pyright)
				'clangd',  -- 添加 C++ LSP (clangd)
			},
		},
		config = function(_, opts)
			require('mason').setup(opts)
			local mr = require 'mason-registry'
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = { 'saghen/blink.cmp', 'williamboman/mason.nvim' },

		config = function()
			vim.diagnostic.config {
				underline = false,
				signs = false,
				update_in_insert = false,
				virtual_text = { spacing = 2, prefix = '●' },
				severity_sort = true,
				float = {
					border = 'rounded',
				},
			}

			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require 'lspconfig'

			-- Lua LSP
			lspconfig['lua_ls'].setup { capabilities = capabilities }

			-- Python LSP (pyright)
			lspconfig['pyright'].setup { capabilities = capabilities }

			-- C++ LSP (clangd)
			lspconfig['clangd'].setup { capabilities = capabilities }

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- 这些键位映射是通用的，会自动应用于当前活动的 LSP
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = '[LSP] Hover' })
					vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {
						buffer = ev.buf,
						desc = '[LSP] Show diagnostic',
					})
					vim.keymap.set('n', '<leader>gk', vim.lsp.buf.signature_help,
						{ buffer = ev.buf, desc = '[LSP] Signature help' })
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[LSP] Add workspace folder' })
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
						{ desc = '[LSP] Remove workspace folder' })
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { desc = '[LSP] List workspace folders' })
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = '[LSP] Rename' })
					-- 您可以根据需要为特定LSP添加更具体的键位映射或配置
					-- 例如，如果某个LSP有特殊的命令
					-- if client.name == "pyright" then
					--   -- 为 pyright 设置特定键位
					-- end
				end,
			})
		end,
	},
	{
		'folke/lazydev.nvim',
		ft = 'lua', -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
}
