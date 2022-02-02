local cmd, g, opt = vim.cmd, vim.g, vim.opt

local MAP_DEFAULTS = {noremap = true}
local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", MAP_DEFAULTS, opts or {})
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-----------------------------
---------- Plugins ----------
-----------------------------
local install_path = vim.fn.stdpath("data") ..
                         "/site/pack/packer/start/packer.nvim"

local packer_bootstrap = false
if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system {
    "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  packer_bootstrap = true
end
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "lifepillar/vim-gruvbox8"

  -- Custom filetypes
  use "chr4/nginx.vim"
  use "JuliaEditorSupport/julia-vim"
  use "plasticboy/vim-markdown"
  -- For :TableFormat in markdown
  use "godlygeek/tabular"

  -- General editing
  -- Easier commenting for any language
  use "tpope/vim-commentary"
  -- Additional text objects
  use "wellle/targets.vim"
  -- Surrounding text objects with any character
  use "machakann/vim-sandwich"
  -- Vim undotree visualizer
  use "mbbill/undotree"
  -- Never think about indentation
  use "tpope/vim-sleuth"
  -- https://EditorConfig.org
  use "editorconfig/editorconfig-vim"
  -- Git
  use "tpope/vim-fugitive"

  -- Multi-cursor
  -- use "mg979/vim-visual-multi"
  -- g.VM_leader = "\\"
  -- g.VM_maps = {["Add Cursor Down"] = "<M-j>", ["Add Cursor Up"] = "<M-k>"}

  -- The file manager I made. I normally just symlink it
  -- use "elihunter173/dirbuf.nvim"

  -- Floating terminal
  use "voldikss/vim-floaterm"

  -- Fuzzy finding
  use {
    "junegunn/fzf",
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end,
  }
  use "junegunn/fzf.vim"

  -- Zettelkasten notes
  use "mickael-menu/zk-nvim"

  -- LSP, snippets, and autocomplete
  use "neovim/nvim-lspconfig"
  use "L3MON4D3/LuaSnip"
  -- TODO: Check out coq.nvim?
  use {"hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip"}

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-refactor",
  }

  -- Formatting
  use "mhartington/formatter.nvim"
end)

if packer_bootstrap then
  require("packer").sync()
  cmd "autocmd User PackerComplete echo 'Initial bootstrap done. Run :quitall and restart'"
  return
end

-----------------------------
---------- Options ----------
-----------------------------
opt.number = true
opt.wrap = false
opt.tabstop = 4
-- filetype plugin indent on is default in Neovim
-- Enable mouse support for all modes
opt.mouse = "a"
-- Pad cursor when scrolling
opt.scrolloff = 1
opt.sidescrolloff = 0
-- Show hidden characters
opt.listchars = {
  tab = "> ",
  trail = "-",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}
opt.list = true
-- Make splitting make more sense
opt.splitbelow = true
opt.splitright = true
-- No annoying sound or blink on errors
opt.errorbells = false
opt.visualbell = false
-- Why would you ever put 2 spaces after punctuation??
opt.joinspaces = false
-- Useful name in terminal
opt.title = true
-- Don't redraw during macros and more (for performance)
opt.lazyredraw = true
-- Better completion experience
opt.completeopt = {"menu", "menuone", "noselect"}
opt.shortmess:append("c")
-- Persistent undo
opt.undofile = true
-- Incremental :substitute preview in same buffer
opt.inccommand = "nosplit"
-- ripgrep >> grep
opt.grepprg = "rg --vimgrep"
-- Use system clipboard
opt.clipboard = "unnamedplus"

-- Statusline
opt.laststatus = 2
function MYFILENAME()
  local name = vim.fn.expand("%")
  if name == "" then
    return "[No Name]"
  elseif vim.fn.isdirectory(name) == 1 then
    return name
  else
    return vim.fn.fnamemodify(name, ":~:.")
  end
end
opt.statusline = "%{v:lua.MYFILENAME()}%m%r%w%q%=%l,%c%{' '.FugitiveHead()}"

-- Colorscheme
if os.getenv("TERM") ~= "screen" then
  opt.termguicolors = true
end
opt.background = "dark"

-- Automatically enable spelling on certain files
cmd "autocmd FileType tex,markdown setlocal spell"
-- Use single-line comments for C and C++
cmd "autocmd FileType c,cpp set commentstring=//%s"

-----------------------------
---------- Mappings ----------
-----------------------------
-- TODO: See if theres a Lua native way to do this
cmd "let mapleader = ' '"
map("n", "<leader>w", "<cmd>write<cr>")
-- Make leader keybindings less awkward
map("n", " ", "")
-- s is used by vim sandwich
map("n", "s", "")

-- Send c to black hole
map("n", "c", "\"_c")
map("n", "C", "\"_C")
map("v", "c", "\"_c")
map("v", "C", "\"_C")

-- Turn off search highlighting because vim doesn't do that by default for some
-- reason
map("n", "<leader>s", "<cmd>nohlsearch<cr>")

-- Easier window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Quickfix mapping. Taken from tpope/vim-unimpaired
map("n", "]q", "<cmd>cnext<cr>")
map("n", "[q", "<cmd>cprev<cr>")

-- Easier terminal opening. L for shell
map("n", "<leader>l", "<cmd>terminal<cr>")
-- Easier escape
map("t", "<esc>", "<C-\\><C-n>")
-- Easier window navigation
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
-- Make terminals always open in insert mode with no linenumbers.
-- TODO: Use autocmd API when it gets finished
cmd "autocmd TermOpen * startinsert | setlocal norelativenumber nonumber"

-- Add todo comments
-- TODO: Make this less hacky
map("n", "<leader>c",
    "<cmd>call append('.', substitute(&commentstring, '\\s*%s\\s*', ' TODO: ', ''))<cr>j==f:la")
map("n", "<leader>C",
    "<cmd>call append(line('.')-1, substitute(&commentstring, '\\s*%s\\s*', ' TODO: ', ''))<cr>k==f:la")

-----------------------------
------- Plugin Config -------
-----------------------------
-- Colorscheme
g.gruvbox_italicize_strings = 0
cmd "colorscheme gruvbox8"

-- EditorConfig + Fugitive
g.EditorConfig_exclude_patterns = {"fugitive://.\\*"}

-- Fugitive
map("n", "<leader>gs", "<cmd>Git<cr>")
map("n", "<leader>gp", "<cmd>Git push<cr>")

-- Disable Netrw because of dirbuf.nvim + packer.nvim annoyance
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Markdown shit
g.vim_markdown_folding_disabled = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_auto_insert_bullets = 0
g.vim_markdown_new_list_item_indent = 2
g.vim_markdown_math = 1
-- Don't conceal in LaTeX
g.tex_conceal = ""

-- Don't open unnecessary files
g.fzf_buffers_jump = 1
g.fzf_layout = {window = {width = 0.85, height = 0.8}}
g.fzf_preview_window = ""
-- Nice fzf keybindings
cmd [[
command! -bang -nargs=? -complete=dir Directories
  \ call fzf#run(fzf#wrap({'source': 'fd --type directory' . ('<bang>' == '!' ? ' --hidden' : '')}))
command! -bang -nargs=? -complete=dir Files
  \ call fzf#run(fzf#wrap({'source': 'fd --type file' . ('<bang>' == '!' ? ' --hidden' : '')}))
]]
map("n", "<leader>o", "<cmd>Files<cr>")
map("n", "<leader>O", "<cmd>Files!<cr>")
map("n", "<leader>p", "<cmd>Directories<cr>")
map("n", "<leader>P", "<cmd>Directories!<cr>")
map("n", "<leader>i", "<cmd>BLines<cr>")
map("n", "<leader>I", "<cmd>Rg<cr>")

-- Floaterm
map("n", "<leader>t", "<cmd>FloatermToggle<cr>")
g.floaterm_width = 0.8
g.floaterm_height = 0.8

--------------------------------
---------- Formatting ----------
--------------------------------
-- TODO: Remove all command line configuration in favor of config files?
local prettier = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--trailing-comma=all",
      "--print-width=100",
    },
    stdin = true,
  }
end

local function fmt_call(exe, ...)
  local tbl = {exe = exe, args = {...}, stdin = true}
  return function()
    return tbl
  end
end

require("formatter").setup {
  logging = false,
  filetype = {
    html = {prettier},
    css = {prettier},
    scss = {prettier},
    javascript = {prettier},
    typescript = {prettier},
    vue = {prettier},
    json = {prettier},
    lua = {
      fmt_call("lua-format", "--indent-width=2", "--extra-sep-at-table-end",
               "--no-keep-simple-control-block-one-line",
               "--no-keep-simple-function-one-line",
               "--single-quote-to-double-quote"),
    },
    python = {fmt_call("black", "-"), fmt_call("isort", "-")},
    rust = {fmt_call("rustfmt", "--edition=2018", "--emit=stdout")},
    c = {fmt_call("clang-format")},
    cpp = {fmt_call("clang-format")},
  },
}
map("n", "<leader>f", "<cmd>Format<cr>")

--------------------------------
---------- Snippets ------------
--------------------------------
local luasnip = require("luasnip")
local env_snippet = luasnip.parser.parse_snippet("env", [[
\begin{$1}
  $0
\end{$1}]])
luasnip.snippets = {
  tex = {env_snippet},
  markdown = {env_snippet},
  rust = {
    luasnip.parser.parse_snippet("macro", [[
macro_rules! $1 {
  ($2) => {
    $0
  };
}]]), luasnip.parser.parse_snippet("test", [[
#[test]
fn test_$1() {
  $0
}]]),
  },
}

--------------------------------
------ LSP & Autocomplete ------
--------------------------------
local cmp = require("cmp")
cmp.setup {
  source = {
    -- TODO: Only enable this in custom_attach?
    nvim_lsp = true,
    -- TODO: Make snippets higher priorty than nvim_lsp?
    snippets_nvim = true,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({select = true}),
  },
  sources = {{name = "nvim_lsp"}, {name = "luasnip"}},
}

local function lsp_attach(_, bufnr)
  local function bufmap(mode, lhs, rhs)
    local opts = vim.tbl_extend("force", MAP_DEFAULTS, {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>")
  bufmap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<cr>")
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
  bufmap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>")
  bufmap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  bufmap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
  bufmap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
  bufmap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>")
  bufmap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
  bufmap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")
  bufmap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  bufmap("n", "ge", "<cmd>lua vim.diagnostic.show_line_diagnostics()<cr>")
  bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

  print("LSP Attached.")
end

local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_extend("force",
                                               lspconfig.util.default_config, {
  on_attach = lsp_attach,
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol
                                                                 .make_client_capabilities()),
})

lspconfig.pylsp.setup {}
lspconfig.jdtls.setup {}
lspconfig.tsserver.setup {}
lspconfig.vimls.setup {}
lspconfig.sumneko_lua.setup {
  cmd = {
    os.getenv("HOME") .. "/bin/lua-language-server", "-E",
    os.getenv("HOME") .. "/src/build/lua-language-server/main.lua",
  },
  settings = {
    Lua = {
      runtime = {version = "LuaJIT"},
      diagnostics = {
        globals = {
          "vim", -- neovim
          "awesome", "client", "screen", -- awesome
          "describe", "it", "pending", -- busted
        },
      },
    },
  },
}
lspconfig.bashls.setup {}
lspconfig.texlab.setup {}
lspconfig.gopls.setup {}
lspconfig.clangd.setup {}
lspconfig.rust_analyzer.setup {}

--------------------------------
------ Zettelkasten notes ------
--------------------------------
require("zk").setup {picker = "fzf", lsp = {config = {on_attach = lsp_attach}}}

require("zk.commands").add("ZkEdit", function()
  require("zk").edit({}, {
    fzf_options = {
      [[--bind=Ctrl-N:abort+execute(nvr +"close | ZkNew { title = {q} }")]],
      [[--header=Ctrl-N: create a note with the query as title]],
    },
  })
end)

require("zk.commands").add("ZkLink", function(options)
  if options == nil then
    options = {}
  end
  local picker_options = {title = "Zk Insert Link"}
  require("zk").pick_notes(options, picker_options, function(notes)
    for _, note in ipairs(notes) do
      local link = "[" .. note.title .. "](" .. note.path .. ")"
      vim.api.nvim_put({link}, "c", true, true)
    end
  end)
end)

require("zk.commands").add("ZkLinkSelection", function(options)
  -- TODO: This boilerplate is necessary until
  -- https://github.com/neovim/neovim/pull/13896 is merged
  -- This was taken from the ZkMatch implementation
  local range = require("zk.util").get_selected_range()
  local text = require("zk.util").get_text_in_range(range)
  assert(text ~= nil, "No selected text")
  options = vim.tbl_extend("force", {match = text}, options or {})
  local picker_options = {
    title = "Zk Insert Link matching " .. vim.inspect(text),
  }

  require("zk").pick_notes(options, picker_options, function(notes)
    assert(#notes == 1, "Only select one note")
    local note = notes[1]
    local link = "[" .. text .. "](" .. note.path .. ")"
    vim.api.nvim_buf_set_text(0, range.start.line, range.start.character,
                              range["end"].line, range["end"].character, {link})
  end)
end, {needs_selection = true})

map("n", "<leader>n", "<cmd>ZkEdit<cr>")
map("v", "<leader>n", "<cmd>'<,'>ZkNewFromTitleSelection<cr>")
map("n", "<leader>m", "<cmd>ZkLink<cr>")
map("v", "<leader>m", ":ZkLinkSelection<cr>")
cmd "command! ZkUpdate !zk update"

--------------------------------
---------- TreeSitter ----------
--------------------------------
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
cmd "autocmd BufRead,BufNewFile *.lalrpop set filetype=lalrpop"
cmd "autocmd FileType lalrpop set commentstring=//%s"
parser_config.rust.used_by = "lalrpop"
require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = {
    -- Enable nested language parsers
    use_languagetree = true,
    enable = true,
  },
}
-- This is kinda illegal. I took this from the CursorHold autocmd
map("n", "S",
    "<cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<cr>",
    {silent = true})
