-- global
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

vim.opt.statusline = " %f %= %y | %l:%c | %{&fileencoding} | %p%%  "

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
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")


