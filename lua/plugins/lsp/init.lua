-- ~/.config/nvim/lua/plugins/lsp/init.lua
-- Executed after plugins are loaded
require("plugins.lsp.on-attach")     -- keymaps & autoformat
--require("plugins.lsp.formatting")    -- diagnostics & signs
require("plugins.lsp.languages.c")   -- c configuration
require("plugins.lsp.languages.lua") -- lua_ls configuration
require("plugins.lsp.languages.tex")
require("plugins.lsp.languages.python")
