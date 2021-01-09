-- Short aliases
local cmd, g = vim.cmd, vim.g

local MAP_DEFAULTS = {noremap = true}
local function map(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs,
                          vim.tbl_extend("force", MAP_DEFAULTS, opts or {}))
end
local function bufmap(mode, lhs, rhs, opts)
  -- 0 means current buffer
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs,
                              vim.tbl_extend("force", MAP_DEFAULTS, opts or {}))
end

-- TODO: Remove when https://github.com/neovim/neovim/pull/13479 lands
local opts_info = vim.api.nvim_get_all_options_info()
local opt = setmetatable({}, {
  __index = vim.o,
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == "win" then
      vim.wo[key] = value
    elseif scope == "buf" then
      vim.bo[key] = value
    end
  end,
})

---------- Options ----------
-- Enable line numbers and ruler
opt.number = true
opt.relativenumber = true
-- Enable ftplugins for everything
-- filetype plugin indent on is default in Neovim
-- Enable mouse support for all modes
opt.mouse = "a"
-- Pad cursor when scrolling
opt.scrolloff = 1
opt.sidescrolloff = 5
-- Show hidden characters
opt.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+"
opt.list = true
-- Make splitting make more sense
opt.splitbelow = true
opt.splitright = true
-- No annoying sound or blink on errors
opt.errorbells = false
opt.visualbell = false
-- Why would you ever put 2 spaces after punctuation??
opt.joinspaces = false
-- Give yourself a useful name in the terminal
opt.title = true
-- A more civilized tab
opt.tabstop = 4
-- Don't redraw during macros (for performance)
opt.lazyredraw = true
-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noinsert,noselect"
-- Avoid showing message extra message when using completion
opt.shortmess = opt.shortmess .. "c"
-- Persistent undo
opt.undofile = true
-- Incremental :substitute preview in same buffer
opt.inccommand = "nosplit"
-- GUI Font settings
opt.guifont = "Hack:h12"
-- ripgrep >> grep
opt.grepprg = "rg --vimgrep"

-- Statusline
opt.laststatus = 2
opt.statusline = "%f%m%r%w%q%=%{FugitiveHead()}"

-- Colorscheme
if os.getenv("TERM") ~= "screen" then
  opt.termguicolors = true
end
opt.background = "dark"

---------- Mappings ----------
-- TODO: How do I do this more natively?
cmd "let mapleader = ' '"
-- Prevent space from moving forward in normal mode
map("n", " ", "")

-- I like using s for other mappings
map("n", "s", "")

-- Make saving and quitting easier and faster
map("n", "<leader>w", "<cmd>write<cr>")

-- Turn off search highlighting because vim doesn't do that by default for some
-- reason
map("n", "<leader>s", "<cmd>nohlsearch<cr>")

-- Easier window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Quickfix mapping. Taken from tpope/vim-unimpaired. I used to have the whole
-- plugin but this is all I used.
map("n", "]q", "<cmd>cnext<cr>")
map("n", "[q", "<cmd>cprev<cr>")

--- Terminal settings
-- Easier terminal opening. L for shell
map("n", "<leader>l", "<cmd>terminal<cr>")
-- Easier escape
map("t", "<esc>", "<C-\\><C-n>")
-- Easier window navigation
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
-- Make terminals always open in insert mode and no linenumbers in
-- terminals.
-- TODO: Use augroup API when it gets finished
cmd "augroup TermSettings"
cmd "  autocmd!"
cmd "  autocmd TermOpen * startinsert | setlocal norelativenumber nonumber"
cmd "augroup END"

-- Replace the current line with todo comment
-- TODO: Make this less hacky
map("n", "<leader>c",
    "<cmd>call append('.', substitute(&commentstring, '\\s*%s\\s*', ' TODO: ', ''))<cr>j==f:la")
map("n", "<leader>C",
    "<cmd>call append(line('.')-1, substitute(&commentstring, '\\s*%s\\s*', ' TODO: ', ''))<cr>k==f:la")

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
g.VM_maps = {["Add Cursor Down"] = "<M-j>", ["Add Cursor Up"] = "<M-k>"}

-- Neovim's CursorHold is a little laggy right now. This fixes that.
paq "antoinemadec/FixCursorHold.nvim"

-- Lightweight git wrapper
-- TODO: Check out Gina.vim
paq "tpope/vim-fugitive"
map("n", "<leader>gs", "<cmd>Gstatus<cr>")
map("n", "<leader>gp", "<cmd>Gpush<cr>")

-- Netrw but simpler and better
-- paq "justinmk/vim-dirvish"
-- Disable netrw because I use Dirvish
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1

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
g.fzf_layout = {window = {width = 0.85, height = 0.8}}
g.fzf_preview_window = ""
-- Nice keybindings
map("n", "<leader>o", "<cmd>Files<cr>")

-- Floating terminal
paq "voldikss/vim-floaterm"
map("n", "<leader>t", "<cmd>FloatermToggle<cr>")
g.floaterm_width = 0.8
g.floaterm_height = 0.8

---------- LSP ----------
paq "neovim/nvim-lspconfig"
paq "nvim-lua/completion-nvim"
local lspconfig = require("lspconfig")
local nvim_completion = require("completion")

local custom_attach = function()
  nvim_completion.on_attach()

  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", {silent = true})
  bufmap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent = true})
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {silent = true})
  bufmap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", {silent = true})
  bufmap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
         {silent = true})
  bufmap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
         {silent = true})
  bufmap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>",
         {silent = true})
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", {silent = true})
  bufmap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", {silent = true})
  bufmap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<cr>",
         {silent = true})
  bufmap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>",
         {silent = true})
  bufmap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", {silent = true})
  bufmap("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>",
         {silent = true})
  bufmap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
         {silent = true})
  bufmap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
         {silent = true})

  print("LSP Attached.")
end

lspconfig.pyls.setup {on_attach = custom_attach}
lspconfig.jdtls.setup {on_attach = custom_attach}

lspconfig.vimls.setup {on_attach = custom_attach}
lspconfig.sumneko_lua.setup {
  cmd = {
    os.getenv("HOME") ..
        "/build/lua-language-server/bin/Linux/lua-language-server", "-E",
    os.getenv("HOME") .. "/build/lua-language-server/main.lua",
  },
  on_attach = custom_attach,
  settings = {
    Lua = {
      runtime = {version = "LuaJIT"},
      diagnostics = {
        globals = {
          "vim", -- vim
          "describe", "it", -- busted
        },
      },
    },
  },
}

lspconfig.yamlls.setup {on_attach = custom_attach}
lspconfig.bashls.setup {on_attach = custom_attach}

lspconfig.texlab.setup {on_attach = custom_attach}

lspconfig.clangd.setup {on_attach = custom_attach}
lspconfig.rust_analyzer.setup {on_attach = custom_attach}

-- A nice tagbar for LSP
paq "liuchengxu/vista.vim"
-- Pretty icons don't work everywhere and are idiosyncratic IMO
g["vista#renderer#enable_icon"] = 0
g.vista_fold_toggle_icons = {"-", "+"}

---------- TreeSitter ----------
paq "nvim-treesitter/nvim-treesitter"
paq "nvim-treesitter/nvim-treesitter-refactor"
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
cmd "autocmd BufRead,BufNewFile *.lalrpop set filetype=lalrpop"
parser_config.rust.used_by = "lalrpop"
require"nvim-treesitter.configs".setup {
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
map("n", "S",
    "<cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<cr>",
    {silent = true})

---------- Formatting ----------
local prettier = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true,
  }
end
local clang_format = function()
  return {exe = "clang-format", args = {}, stdin = true}
end
paq "mhartington/formatter.nvim"
require("formatter").setup {
  logging = false,
  filetype = {
    html = {prettier},
    css = {prettier},
    scss = {prettier},
    javascript = {prettier},
    typescript = {prettier},
    lua = {
      function()
        return {
          exe = "lua-format",
          args = {
            "--indent-width=2", "--extra-sep-at-table-end",
            "--no-keep-simple-control-block-one-line",
            "--no-keep-simple-function-one-line",
            "--single-quote-to-double-quote",
          },
          stdin = true,
        }
      end,
    },
    python = {
      function()
        return {exe = "black", args = {"-"}, stdin = true}
      end,
    },
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = {"--edition=2018", "--emit=stdout"},
          stdin = true,
        }
      end,
    },
    c = {clang_format},
    cpp = {clang_format},
  },
}
map("n", "<leader>f", "<cmd>Format<cr>")
