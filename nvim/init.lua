local map = vim.api.nvim_set_keymap

---------- Options ----------
-- Enable line numbers and ruler
vim.wo.number = true
vim.wo.relativenumber = true
-- Enable ftplugins for everything
-- filetype plugin indent on is default in Neovim
-- Enable mouse support for all modes
vim.o.mouse = "a"
-- Pad cursor when scrolling
vim.o.scrolloff = 1
vim.o.sidescrolloff = 5
-- Show hidden characters
vim.o.listchars = "tab:>\\ ,trail:-,extends:>,precedes:<,nbsp:+"
vim.o.list = true
-- Make splitting make more sense
vim.o.splitbelow = true
vim.o.splitright = true
-- No annoying sound or blink on errors
vim.o.errorbells = false
vim.o.visualbell = false
-- Why would you ever put 2 spaces after punctuation??
vim.o.joinspaces = false
-- Give yourself a useful name in the terminal
vim.o.title = true
-- A more civilized tab
vim.o.tabstop = 4
-- Don't redraw during macros (for performance)
vim.o.lazyredraw = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"
-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"
-- Persistent undo
vim.o.undofile = true
-- Incremental :substitute preview in same buffer
vim.o.inccommand = "nosplit"
-- GUI Font settings
vim.o.guifont = "Hack:h12"
-- ripgrep >> grep
vim.o.grepprg = "rg --vimgrep"

-- Statusline
-- TODO: Colors?
vim.o.laststatus = 2
vim.o.statusline = "%f%m%r%w%q%=%{FugitiveHead()}"

-- Colorscheme
if os.getenv("TERM") ~= "screen" then
  vim.o.termguicolors = true
end
vim.o.background = "dark"
-- TODO: Figure out if there's a better way to set colorschemes in lua
vim.cmd "colorscheme solarized8"

---------- Mappings ----------
-- TODO: How do I do this more natively?
vim.cmd "let mapleader = ' '"
-- Prevent space from moving forward in normal mode
map("n", " ", "<NOP>", {noremap = true})

-- I like using s for other mappings
map("n", "s", "<NOP>", {noremap = true})

-- Make saving and quitting easier and faster
map("n", "<leader>w", "<cmd>write<cr>", {noremap = true})

-- Turn off search highlighting because vim doesn't do that by default for some
-- reason
map("n", "<leader>s", "<cmd>nohlsearch<cr>", {noremap = true})

-- Easier window navigation
map("n", "<C-h>", "<C-w>h", {noremap = true})
map("n", "<C-l>", "<C-w>l", {noremap = true})
map("n", "<C-j>", "<C-w>j", {noremap = true})
map("n", "<C-k>", "<C-w>k", {noremap = true})

-- Quickfix mapping. Taken from tpope/vim-unimpaired. I used to have the whole
-- plugin but this is all I used.
map("n", "]q", "<cmd>cnext<cr>", {noremap = true})
map("n", "]q", "<cmd>cnext<cr>", {noremap = true})

--- Terminal settings
-- Easier terminal opening. L for shell
map("n", "<leader>l", "<cmd>terminal<cr>", {noremap = true})
-- Easier escape
map("t", "<esc>", "<C-\\><C-n>", {noremap = true})
-- Easier window navigation
map("t", "<C-h>", "<C-\\><C-n><C-w>h", {noremap = true})
map("t", "<C-j>", "<C-\\><C-n><C-w>j", {noremap = true})
map("t", "<C-k>", "<C-\\><C-n><C-w>k", {noremap = true})
map("t", "<C-l>", "<C-\\><C-n><C-w>l", {noremap = true})
-- Make terminals always open in insert mode and no linenumbers in
-- terminals.
-- TODO: Use augroup API when it gets finished
vim.cmd "augroup TermSettings"
vim.cmd "  autocmd!"
vim.cmd "  autocmd TermOpen * startinsert | setlocal norelativenumber nonumber"
vim.cmd "augroup END"

-- Replace the current line with todo comment
-- TODO: Make this less hacky
map(
  "n", "<leader>c",
  "<cmd>call append('.', substitute(&commentstring, '\\s*%s\\s*', ' TODO: ', ''))<cr>j==f:la",
  {noremap = true})
map(
  "n", "<leader>C",
  "<cmd>call append(line('.')-1, substitute(&commentstring, '\\s*%s\\s*', ' TODO: ', ''))<cr>k==f:la",
  {noremap = true})

---------- Plugins ----------
-- TODO: Inline me with paq-nvim
require("plugins")

--[[
local paq_exists = pcall(vim.cmd, "packadd paq-nvim")
if not paq_exists then
  local directory = vim.fn.stdpath("data") .. "/site/pack/paqs/opt"

  vim.fn.mkdir(directory, "p")
  local out = vim.fn.system(string.format(
      "git clone %s %s",
      "https://github.com/savq/paq-nvim.git",
      directory .. "/paq-nvim"
    ))
  print(out)
  print("Downloading pac-nvim...")
end
--]]
