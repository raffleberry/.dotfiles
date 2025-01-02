local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "html" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true }, 
  auto_install = true
})
