--Cursor settings //Might not work for all terminals
--terminal settings might take precedence
vim.opt.guicursor = {
    "n-v-c:block-Cursor", 
    "i:ver25-CursorInsert", 
    "r-cr-o:hor20-CursorReplace", 
}
vim.cmd [[
  highlight Cursor guifg=white guibg=yellow
  highlight CursorInsert guifg=white guibg=yellow
  highlight CursorReplace guifg=white guibg=yellow
]]

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""
