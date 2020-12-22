-- Short aliases
local g = vim.g
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap
local bufmap = function(mode, lhs, rhs, opts)
  -- 0 means current buffer
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

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
vim.o.laststatus = 2
vim.o.statusline = "%f%m%r%w%q%=%{FugitiveHead()}"

-- Colorscheme
if os.getenv("TERM") ~= "screen" then
  vim.o.termguicolors = true
end
vim.o.background = "dark"

---------- Mappings ----------
-- TODO: How do I do this more natively?
cmd "let mapleader = ' '"
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
cmd "augroup TermSettings"
cmd "  autocmd!"
cmd "  autocmd TermOpen * startinsert | setlocal norelativenumber nonumber"
cmd "augroup END"

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
cmd "packadd paq-nvim"
local paq = require("paq-nvim").paq
-- Let paq manage itself
paq {"savq/paq-nvim", opt = true}

-- Colorscheme
paq "lifepillar/vim-solarized8"
-- TODO: Figure out if there's a better way to set colorschemes in lua
cmd "colorscheme solarized8"

-- General editing
-- Easier commenting for any language
paq "tpope/vim-commentary"
-- Additional text objects
paq "wellle/targets.vim"
-- Surrounding text objects with any character
paq "machakann/vim-sandwich"

-- Configuration stuff
-- Never think about indentation
paq "tpope/vim-sleuth"

-- https://EditorConfig.org
paq "editorconfig/editorconfig-vim"
-- EditorConfig + Fugitive
g.EditorConfig_exclude_patterns = {"fugitive://.\\*"}

-- Multi-cursor support!
paq "mg979/vim-visual-multi"
g.VM_leader = "\\"
g.VM_maps = {
  ["Add Cursor Down"] = "<M-j>",
  ["Add Cursor Up"] = "<M-k>",
}

-- Neovim's CursorHold is a little laggy right now. This fixes that.
paq "antoinemadec/FixCursorHold.nvim"

-- Lightweight git wrapper
-- TODO: Check out Gina.vim
paq "tpope/vim-fugitive"
map("n", "<leader>gs", "<cmd>Gstatus<CR>", {noremap = true})
map("n", "<leader>gp", "<cmd>Gpush<CR>", {noremap = true})

-- Netrw but simpler and better
paq "justinmk/vim-dirvish"
-- Disable netrw becapaq I use Dirvish
g.loaded_netrwPlugin = 1

-- Syntax highlighting for more languages
paq "plasticboy/vim-markdown"
-- For :TableFormat in markdown
paq "godlygeek/tabular"
-- Markdown shit
g.vim_markdown_folding_disabled = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_auto_insert_bullets = 0
g.vim_markdown_new_list_item_indent = 2
-- LaTeX with no concealing
g.tex_conceal = ""
g.vim_markdown_math = 1

-- Vim undotree visualizer
paq "mbbill/undotree"

-- Fuzzy finding!
paq "junegunn/fzf.vim"
-- Don't open unnecessary files
g.fzf_buffers_jump = 1
g.fzf_layout = { window = { width = 0.85, height = 0.8 } }
g.fzf_preview_window = ""
-- Nice keybindings
map("n", "<leader>o", "<cmd>BLines<CR>", {noremap = true})
map("n", "<leader>O", "<cmd>Files<CR>", {noremap = true})

-- paq "jiangmiao/auto-pairs"
-- endwise isn't working for some reason
-- paq {
--   "tpope/vim-endwise",
--   config = function()
--     vim.api.nvim_command [[
--     autocmd FileType tex
--     \ let b:endwise_addition = '\="\\end" . matchstr(submatch(0), "{.\\{-}}")' |
--     \ let b:endwise_words = 'begin' |
--     \ let b:endwise_pattern = '\\begin{.\{-}}' |
--     \ let b:endwise_syngroups = 'texSection,texBeginEnd,texBeginEndName,texStatement'
--     ]]
--   end,
-- }

-- Floating terminal
paq "voldikss/vim-floaterm"
map("n", "<leader>t", "<cmd>FloatermToggle<CR>", {noremap = true})
g.floaterm_width = 0.8
g.floaterm_height = 0.8

-- LSP
---------- LSP ----------
paq "neovim/nvim-lspconfig"
paq "nvim-lua/completion-nvim"
local lspconfig = require("lspconfig")
local nvim_completion = require("completion")

local custom_attach = function()
  nvim_completion.on_attach()

  bufmap("n", "gd",        "<cmd>lua vim.lsp.buf.declaration()<CR>",                  {silent = true, noremap = true})
  bufmap("n", "<c-]>",     "<cmd>lua vim.lsp.buf.definition()<CR>",                   {silent = true, noremap = true})
  bufmap("n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>",                        {silent = true, noremap = true})
  bufmap("n", "gD",        "<cmd>lua vim.lsp.buf.implementation()<CR>",               {silent = true, noremap = true})
  bufmap("n", "<C-s>",     "<cmd>lua vim.lsp.buf.signature_help()<CR>",               {silent = true, noremap = true})
  bufmap("n", "<C-s>",     "<cmd>lua vim.lsp.buf.signature_help()<CR>",               {silent = true, noremap = true})
  bufmap("n", "1gD",       "<cmd>lua vim.lsp.buf.type_definition()<CR>",              {silent = true, noremap = true})
  bufmap("n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>",                   {silent = true, noremap = true})
  bufmap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>",                       {silent = true, noremap = true})
  bufmap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>",                   {silent = true, noremap = true})
  bufmap("n", "g0",        "<cmd>lua vim.lsp.buf.document_symbol()<CR>",              {silent = true, noremap = true})
  bufmap("n", "gW",        "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>",             {silent = true, noremap = true})
  bufmap("n", "ga",        "<cmd>lua vim.lsp.buf.code_action()<CR>",                  {silent = true, noremap = true})
  bufmap("n", "ge",        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", {silent = true, noremap = true})
  bufmap("n", "]d",        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",             {silent = true, noremap = true})
  bufmap("n", "[d",        "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",             {silent = true, noremap = true})

  print("LSP Attached.")
end

lspconfig.pyls.setup{ on_attach = custom_attach }
lspconfig.jdtls.setup{ on_attach = custom_attach }

lspconfig.vimls.setup{ on_attach = custom_attach }
lspconfig.sumneko_lua.setup {
  cmd = {
    vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
    "-E",
    vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server/main.lua",
  },
  on_attach = custom_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          -- vim
          "vim",
          -- busted
          "describe", "it",
        },
      },
    },
  },
}

lspconfig.yamlls.setup{ on_attach = custom_attach }
lspconfig.bashls.setup{ on_attach = custom_attach }

lspconfig.texlab.setup{ on_attach = custom_attach }

lspconfig.clangd.setup{ on_attach = custom_attach }
lspconfig.rust_analyzer.setup{ on_attach = custom_attach }

-- A nice tagbar for LSP
paq "liuchengxu/vista.vim"
-- Pretty icons don't work everywhere and are idiosyncratic IMO
g["vista#renderer#enable_icon"] = 0
g.vista_fold_toggle_icons = {"-", "+"}

---------- TreeSitter ----------
paq "nvim-treesitter/nvim-treesitter"
paq "nvim-treesitter/nvim-treesitter-refactor"
require'nvim-treesitter.configs'.setup {
  -- one of "all", "language", or a list of languages
  ensure_installed = "all",
  highlight = {
    -- Enable nested language parsers
    use_languagetree = true,
    enable = true,
  },
  -- This doesn't work quite right
  -- indent = {
  --   enable = true
  -- },
}
-- This is kinda illegal. I took this from the CursorHold autocmd
map("n", "S", "<cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<CR>", {noremap = true, silent = true})
