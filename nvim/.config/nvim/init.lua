vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.keymap.set('n', '<C-a>', 'ggVG', {
    noremap = true,
    silent = true
}, {
    desc = 'Select All'
})

vim.keymap.set('n', '<C-s>', ':w<CR>', {
    noremap = true,
    silent = true
}, {
    desc = 'Save File'
})
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', {
    noremap = true,
    silent = true
}, {
    desc = 'Save File'
})
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>', {
    noremap = true,
    silent = true
}, {
    desc = 'Save File'
})

-- editor config
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.wo.relativenumber = true

-- file manager
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = 'File Manager' })

-- system clipboard
vim.keymap.set("v", "<leader>y", "\"+Y", { desc = 'copy to clipboard' })
vim.keymap.set("n", "<leader>y", "\"+Y", { desc = 'copy to clipboard' })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = 'copy to clipboard' })

--
function _G.lsp_status()
  local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
  if next(clients) == nil then
    return "No LSP"
  else
    local active_lsps = {}
    for _, client in pairs(clients) do
      table.insert(active_lsps, client.name)
    end
    return "LSP: " .. table.concat(active_lsps, ", ")
  end
end

vim.opt.statusline = " %f %= %y %{v:lua.lsp_status()} | %{&fileencoding} | %c:[%l/%L] "

function copy_file_directory()
  local dir_path = vim.fn.expand("%:p:h") 
  if dir_path == "" then
    print("No file selected.")
    return
  end

  vim.fn.setreg("+", dir_path)
  print("cd copied to clipboard: " .. dir_path)
end

vim.keymap.set("n", "<leader>cd", ":lua copy_file_directory()<CR>", { noremap = true, silent = true })

-- theme
-- for transparent windows
-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")


