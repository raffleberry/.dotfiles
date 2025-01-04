local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')

local function open_in_new_tab(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local filepath = selected_entry.path or selected_entry.filename
    actions.close(prompt_bufnr)
    vim.cmd('tabnew ' .. vim.fn.fnameescape(filepath))
end

-- Set up Telescope with custom mappings
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                -- Map <C-t> to open in new tab in insert mode
                ["<C-t>"] = open_in_new_tab,
            },
            n = {
                -- Map <C-t> to open in new tab in normal mode
                ["<C-t>"] = open_in_new_tab,
            },
        },
    },
})

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({
        attach_mappings = function(_, map)
            map('i', '<C-t>', open_in_new_tab)
            map('n', '<C-t>', open_in_new_tab)
            return true
        end,
    })
end, { desc = 'Telescope find files', noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })




