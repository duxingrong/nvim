local m = { noremap = true, nowait = true }

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					vim.keymap.set('n', '<c-t>', tstabs.list_tabs, {})  --列出并切换标签页(Tabs)
				end
			},
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			'stevearc/dressing.nvim',
			'dimaportenko/telescope-simulators.nvim',
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<c-p>', builtin.find_files, m) -- 查找文件
			vim.keymap.set('n', '<leader>rs', builtin.resume, m) -- 回复上一次的Telescope搜索
			vim.keymap.set('n', '<c-w>', builtin.buffers, m) -- 列出并切换缓冲区(已打开的文件)
			vim.keymap.set('n', '<c-h>', builtin.oldfiles, m) -- 查找历史文件
			vim.keymap.set('n', '<c-_>', builtin.current_buffer_fuzzy_find, m) -- 在当前文件中模糊搜索
			vim.keymap.set('n', 'z=', builtin.spell_suggest, m) -- 查看拼写建议

			vim.keymap.set('n', '<leader>d', function() -- 查看诊断信息
				builtin.diagnostics({
					sort_by = "severity"
				})
			end, m)

			vim.lsp.protocol.DiagnosticSeverity = {
				"Error",
				"Warning",
				"Information",
				"Hint",
				Error = 1,
				Hint = 4,
				Information = 3,
				Warning = 2
			}

			vim.diagnostic.severity = {
				"ERROR",
				"WARN",
				"INFO",
				"HINT",
				E = 1,
				ERROR = 1,
				HINT = 4,
				I = 3,
				INFO = 3,
				N = 4,
				W = 2,
				WARN = 2
			}
			vim.keymap.set('n', 'gi', builtin.git_status, m) -- 查看git 状态
			vim.keymap.set("n", ":", builtin.commands, m) -- 搜索并执行nvim命令

			local ts = require('telescope')
			local actions = require('telescope.actions')
			ts.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"build",
						"dist",
						"%.pub%-cache",
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--fixed-strings",
						"--smart-case",
						"--trim",
					},
					layout_config = {
						width = 0.9,
						height = 0.9,
					},
					mappings = {
						i = {
							["<F1>"] = "which_key", 
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
							["<C-l>"] = "preview_scrolling_up",
							["<C-h>"] = "preview_scrolling_down",
							["<esc>"] = "close",
							["<C-n>"] = require('telescope.actions').cycle_history_next,
							["<C-p>"] = require('telescope.actions').cycle_history_prev,
						}
					},
					color_devicons = true,
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
						mappings = {
							n = {
								["cd"] = function(prompt_bufnr)
									local selection = require("telescope.actions.state").get_selected_entry()
									local dir = vim.fn.fnamemodify(selection.path, ":p:h")
									require("telescope.actions").close(prompt_bufnr)
									vim.cmd(string.format("silent lcd %s", dir))
								end
							}
						}
					},
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer, -- (仅在缓冲区列表中) 删除当前选中的缓冲区
							},
						}
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				}
			})
			require('dressing').setup({
				select = {
					get_config = function(opts)
						if opts.kind == 'codeaction' then
							return {
								backend = 'telescope',
								telescope = require('telescope.themes').get_cursor()
							}
						end
					end
				}
			})

			ts.load_extension('neoclip')
			-- ts.load_extension('dap')
			ts.load_extension('telescope-tabs')
			-- ts.load_extension('fzf')
			-- ts.load_extension('simulators')

			-- require("simulators").setup({
			-- 	android_emulator = false,
			-- 	apple_simulator = true,
			-- })
			-- ts.load_extension("flutter")
		end
	},
	{
		"FeiyouG/commander.nvim",
		config = function()
			local commander = require("commander")
			commander.setup({
				telescope = {
					enable = true,
				},
			})
			vim.keymap.set('n', '<c-q>', require("commander").show, m)
			commander.add({
				{
					desc = "Run Simulator",
					cmd = "<CMD>Telescope simulators run<CR>",
				},
				{
					desc = "Git diff",
					cmd = "<CMD>Telescope git_status<CR>",
				},
				{
					desc = "Restart Dart LSP",
					cmd = function()
						vim.lsp.start({
							name = 'dartls',
							cmd = { 'dart', 'language-server', '--protocol=lsp' },
							root_dir = vim.fn
									.getcwd()
						})
					end,
				},
			})
		end
	}
}
