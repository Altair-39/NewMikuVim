-- lua/plugins/utility/lualine.lua
return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local lualine = require("lualine")

			-- Function to setup lualine with current colors
			local function setup_lualine()
				-- Get neopywal colors
				local neopywal_ok, neopywal = pcall(require, "neopywal")
				local colors = {}

				if neopywal_ok then
					colors = neopywal.get_colors()
				else
					-- Fallback colors if neopywal fails
					colors = {
						color1 = "#ff0000", -- red
						color2 = "#00ff00", -- green
						color3 = "#0000ff", -- blue
						color4 = "#ffff00", -- yellow
						color5 = "#ff00ff", -- magenta
						color6 = "#00ffff", -- cyan
						color7 = "#ffffff", -- white
						color8 = "#888888", -- gray
						bg = "#000000",
						fg = "#ffffff",
					}
				end

				-- Custom neopywal theme for lualine with colored sections
				local neopywal_theme = {
					normal = {
						a = { bg = colors.color4, fg = colors.bg, gui = "bold" },
						b = { bg = colors.color8, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.fg },
					},
					insert = {
						a = { bg = colors.color6, fg = colors.bg, gui = "bold" },
						b = { bg = colors.color8, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.fg },
					},
					visual = {
						a = { bg = colors.color5, fg = colors.bg, gui = "bold" },
						b = { bg = colors.color8, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.fg },
					},
					replace = {
						a = { bg = colors.color2, fg = colors.bg, gui = "bold" },
						b = { bg = colors.color8, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.fg },
					},
					command = {
						a = { bg = colors.color1, fg = colors.bg, gui = "bold" },
						b = { bg = colors.color8, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.fg },
					},
					inactive = {
						a = { bg = colors.bg, fg = colors.color8, gui = "bold" },
						b = { bg = colors.bg, fg = colors.color8 },
						c = { bg = colors.bg, fg = colors.color8 },
					},
				}

				local conditions = {
					buffer_not_empty = function()
						return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
					end,
					hide_in_width = function()
						return vim.fn.winwidth(0) > 80
					end,
					check_git_workspace = function()
						local filepath = vim.fn.expand("%:p:h")
						local gitdir = vim.fn.finddir(".git", filepath .. ";")
						return gitdir and #gitdir > 0 and #gitdir < #filepath
					end,
				}

				local config = {
					options = {
						component_separators = "",
						section_separators = "",
						theme = neopywal_theme,
					},
					sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_y = {},
						lualine_z = {},
						lualine_c = {},
						lualine_x = {},
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_y = {},
						lualine_z = {},
						lualine_c = {},
						lualine_x = {},
					},
				}

				-- Inserts a component in lualine_c at left section
				local function ins_left(component)
					table.insert(config.sections.lualine_c, component)
				end

				-- Inserts a component in lualine_x at right section
				local function ins_right(component)
					table.insert(config.sections.lualine_x, component)
				end

				-- Colored separator
				ins_left({
					function()
						return "▊"
					end,
					color = { fg = colors.color4 },
					padding = { left = 0, right = 1 },
				})

				-- Colored mode icon
				ins_left({
					function()
						return ""
					end,
					color = function()
						local mode_colors = {
							n = colors.color4, -- normal - yellow
							i = colors.color6, -- insert - cyan
							v = colors.color5, -- visual - magenta
							V = colors.color5, -- visual line - magenta
							[""] = colors.color5, -- visual block - magenta
							c = colors.color1, -- command - red
							r = colors.color2, -- replace - green
							t = colors.color3, -- terminal - blue
						}
						return { fg = mode_colors[vim.fn.mode()] or colors.color4 }
					end,
					padding = { right = 1 },
				})

				-- Colored filesize
				ins_left({
					"filesize",
					cond = conditions.buffer_not_empty,
					color = { fg = colors.color6 },
				})

				-- Colored filename
				ins_left({
					"filename",
					cond = conditions.buffer_not_empty,
					color = { fg = colors.color3 },
					symbols = {
						modified = "  ",
						readonly = "  ",
						unnamed = "[No Name]",
					},
				})

				ins_left({
					"location",
					color = { fg = colors.color8 },
				})

				ins_left({
					"progress",
					color = { fg = colors.color8 },
				})

				-- Colored diagnostics
				ins_left({
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
					colors = {
						error = colors.color1,
						warn = colors.color4,
						info = colors.color6,
						hint = colors.color2,
					},
					colored = true,
					update_in_insert = false,
				})

				-- Middle separator
				ins_left({
					function()
						return "%="
					end,
				})

				-- Colored filetype icon
				ins_left({
					"filetype",
					icons_enabled = true,
					icon_only = true,
					colored = true,
					padding = { right = 1 },
				})

				-- Colored LSP
				ins_left({
					function()
						local msg = "No Active Lsp"
						local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
						local clients = vim.lsp.get_clients()
						if next(clients) == nil then
							return msg
						end
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return client.name
							end
						end
						return msg
					end,
					icon = " LSP:",
					color = { fg = colors.color5 },
				})

				-- Right side components with colors
				ins_right({
					"o:encoding",
					fmt = string.upper,
					cond = conditions.hide_in_width,
					color = { fg = colors.color8 },
				})

				ins_right({
					"fileformat",
					fmt = string.upper,
					icons_enabled = true,
					symbols = {
						unix = "",
						dos = "",
						mac = "",
					},
					color = { fg = colors.color3 },
				})

				ins_right({
					"branch",
					icon = "",
					color = { fg = colors.color2 },
				})

				-- Colored diff
				ins_right({
					"diff",
					symbols = { added = " ", modified = "󰝤 ", removed = " " },
					diff_color = {
						added = { fg = colors.color2 },
						modified = { fg = colors.color4 },
						removed = { fg = colors.color1 },
					},
					colored = true,
					cond = conditions.hide_in_width,
				})

				-- Colored right separator
				ins_right({
					function()
						return "▊"
					end,
					color = { fg = colors.color4 },
					padding = { left = 1 },
				})

				return config
			end

			-- Initial setup
			local config = setup_lualine()
			lualine.setup(config)

			-- Refresh lualine when colors change
			vim.api.nvim_create_autocmd("User", {
				pattern = "NeopywalColorsUpdated",
				callback = function()
					local new_config = setup_lualine()
					lualine.setup(new_config)
					-- Force refresh all statuslines
					vim.cmd("redrawstatus")
				end,
				desc = "Refresh lualine on neopywal color changes",
			})

			-- Alternative: Also refresh on ColorScheme event as backup
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					-- Small delay to ensure neopywal has updated
					vim.defer_fn(function()
						local new_config = setup_lualine()
						lualine.setup(new_config)
						vim.cmd("redrawstatus")
					end, 50)
				end,
				desc = "Refresh lualine on colorscheme changes",
			})
		end,
	},
}
