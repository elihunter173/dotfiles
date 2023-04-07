local cmd, g, opt, map, autocmd = vim.cmd, vim.g, vim.opt, vim.keymap.set, vim.api.nvim_create_autocmd

-- Load impatient.nvim for faster load time
pcall(require, "impatient")

-----------------------------
---------- Plugins ----------
-----------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local bootstrapping = false
if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system {
    "git",
    "clone",
    "--depth=1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  bootstrapping = true
end
require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  -- Faster load time
  use("lewis6991/impatient.nvim")
  -- Colorscheme
  -- New config system forces italic strings and breaks bg0
  use { "ellisonleao/gruvbox.nvim", commit = "3352c12c083d0ab6285a9738b7679e24e7602411" }
  -- Markdown
  use { "plasticboy/vim-markdown", requires = "godlygeek/tabular" }
  -- Easier commenting for any language
  use("numToStr/Comment.nvim")
  -- Additional text objects. TODO: Maybe replace with treesitter stuff
  use("wellle/targets.vim")
  -- Surrounding text objects with any character
  use("machakann/vim-sandwich")
  -- Vim undotree visualizer
  use("mbbill/undotree")
  -- Never think about indentation
  use("tpope/vim-sleuth")
  -- https://EditorConfig.org
  use("editorconfig/editorconfig-vim")
  -- Git
  use({"tpope/vim-fugitive", "tpope/vim-rhubarb"})
  use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }
  -- Multi-cursor
  use("mg979/vim-visual-multi")
  -- Indent marks
  use("lukas-reineke/indent-blankline.nvim")
  -- The file manager I made. I normally just symlink it
  -- use("elihunter173/dirbuf.nvim")
  -- Zettelkasten notes
  use("mickael-menu/zk-nvim")
  -- Floating terminal
  use("voldikss/vim-floaterm")
  -- Fuzzy finding
  use {
    "junegunn/fzf",
    "junegunn/fzf.vim",
    run = function()
      vim.fn["fzf#install"]()
    end,
  }
  -- Justfile support
  use("NoahTheDuke/vim-just")

  -- TODO: See if I actually want this
  use("https://gitlab.com/yorickpeterse/nvim-pqf.git")

  -- LSP and autocomplete
  use("neovim/nvim-lspconfig")
  use { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" }
  use { "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" }
  -- LSP integration for generic things (formatters)
  use { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" }

  -- TreeSitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
end)

if bootstrapping then
  require("packer").sync()
  cmd("autocmd User PackerComplete echo 'Initial bootstrap done. Run :quitall and restart'")
  return
end

-----------------------------
---------- Options ----------
-----------------------------
opt.number = true
opt.relativenumber = true
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
opt.clipboard:append("unnamedplus")
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
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")
-- Better diff
opt.diffopt:append { "iwhiteall", "iblank", "algorithm:histogram" }
-- Persistent undo
opt.undofile = true
-- Incremental :substitute preview in same buffer
opt.inccommand = "nosplit"
-- ripgrep >> grep
opt.grepprg = "rg --vimgrep"
-- I have my mode in my statusline
opt.showmode = false
-- Writing settings
autocmd("FileType", { pattern = { "markdown" }, command = "setlocal spell wrap linebreak breakindent" })
-- I often leave the first word in a sentence lowercase
opt.spellcapcheck = ""

-- Statusline
opt.laststatus = 2
-- Always have filenames be relative
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
opt.statusline = "[%{mode()}] %{v:lua.MYFILENAME()}%m%r%w%q%=%l,%c %{get(b:,'gitsigns_head','')}"

-- Colorscheme
opt.termguicolors = os.getenv("TERM") ~= "screen"
opt.background = "dark"

-----------------------------
--------- Mappings ----------
-----------------------------
g.mapleader = " "
map("n", "<leader>w", "<cmd>write<cr>")
-- Make leader keybindings less awkward
map({ "n", "v" }, " ", "")
-- s is used by vim sandwich
map({ "n", "v" }, "s", "")

-- Go make j/k move soft lines rather than hard lines, except for with counts
map({ "n", "v" }, "j", "v:count ? 'j' : 'gj'", { expr = true })
map({ "n", "v" }, "k", "v:count ? 'k' : 'gk'", { expr = true })

-- Send c to black hole
map("n", "c", '"_c')
map("n", "C", '"_C')
map("v", "c", '"_c')
map("v", "C", '"_C')

-- Turn off search highlighting because vim doesn't do that by default for some
-- reason
map("n", "<leader>s", "<cmd>nohlsearch<cr>")

-- Easier window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Quickfix mapping. Taken from tpope/vim-unimpaired
map("n", "]q", "<cmd>cnext<cr>zz")
map("n", "[q", "<cmd>cprev<cr>zz")

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
cmd("autocmd TermOpen * startinsert | setlocal norelativenumber nonumber signcolumn=no")

-----------------------------
------- Plugin Config -------
-----------------------------
-- Colorscheme
g.gruvbox_sign_column = "bg0"
cmd("colorscheme gruvbox")

-- EditorConfig + Fugitive
g.EditorConfig_exclude_patterns = { "fugitive://.\\*" }

require("Comment").setup()

-- Add todo comments
map("n", "<leader>c", "<cmd>lua require('Comment.api').insert_linewise_below()<cr>TODO: ")
map("n", "<leader>C", "<cmd>lua require('Comment.api').insert_linewise_above()<cr>TODO: ")

-- Fugitive
map("n", "<leader>gs", "<cmd>Git<cr>")
map("n", "<leader>gp", "<cmd>Git push<cr>")

-- Markdown shit
g.vim_markdown_folding_disabled = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_auto_insert_bullets = 0
g.vim_markdown_new_list_item_indent = 2
g.vim_markdown_math = 1
-- Don't conceal in LaTeX
g.tex_conceal = ""

-- TODO: I think I can do this with some lua native thing
autocmd({"BufNewFile","BufRead"}, { pattern=  "*.bazel", command = "set filetype=python"})

-- Dirbuf keycombo
autocmd("FileType", { pattern = "dirbuf", command = "nnoremap <buffer> <C-LeftMouse> <LeftMouse><Plug>(dirbuf_enter)" })

-- Multi-cursor
g.VM_leader = "\\"
g.VM_maps = { ["Add Cursor Down"] = "<M-j>", ["Add Cursor Up"] = "<M-k>" }

-- Don't open unnecessary files
g.fzf_buffers_jump = 1
g.fzf_layout = { window = { width = 0.85, height = 0.8 } }
g.fzf_preview_window = ""
-- Nice fzf keybindings
cmd([[
command! -bang -nargs=? -complete=dir Directories
  \ call fzf#run(fzf#wrap({'source': 'fd --type directory' . ('<bang>' == '!' ? ' --hidden' : '')}))
command! -bang -nargs=? -complete=dir Files
  \ call fzf#run(fzf#wrap({'source': 'fd --type file' . ('<bang>' == '!' ? ' --hidden' : '')}))
]])
map("n", "<leader>o", "<cmd>Files<cr>")
map("n", "<leader>O", "<cmd>Files!<cr>")
map("n", "<leader>p", "<cmd>Directories<cr>")
map("n", "<leader>P", "<cmd>Directories!<cr>")
map("n", "<leader>i", "<cmd>BLines<cr>")
map("n", "<leader>I", "<cmd>Rg<cr>")

-- Floaterm
map("n", "<leader>t", "<cmd>FloatermToggle<cr>")
-- Bigger floaterm
g.floaterm_width = 0.8
g.floaterm_height = 0.8
g.floaterm_opener = "edit"

require("pqf").setup()

-- Git
require("gitsigns").setup {
  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function bufmap(mode, l, r, opts)
      opts = vim.tbl_extend("force", { buffer = bufnr, silent = true }, opts or {})
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    bufmap("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(gs.next_hunk)
      return "<Ignore>"
    end, { expr = true })
    bufmap("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(gs.prev_hunk)
      return "<Ignore>"
    end, { expr = true })

    -- Local (hunk) actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line { full = true }
    end)
    map("n", "<leader>hd", gs.toggle_deleted)
    -- Global actions
    map("n", "<leader>gb", gs.toggle_current_line_blame)
    map("n", "<leader>gd", gs.diffthis)
    map("n", "<leader>gD", function()
      gs.diffthis("~")
    end)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

--------------------------------
------ LSP & Autocomplete ------
--------------------------------
local cmp = require("cmp")
cmp.setup {
  sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- TODO: Look into new mappings
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
}

-- Recommended diagnostic settings
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "<leader>e", vim.diagnostic.open_float)

local function lsp_attach(_, bufnr)
  local function bufmap(mode, lhs, rhs)
    map(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  -- Recommended LSP settings
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  bufmap("n", "gD", vim.lsp.buf.declaration)
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "K", vim.lsp.buf.hover)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  -- bufmap("n", "<C-k>", vim.lsp.buf.signature_help)
  -- These conflict with my :write binding
  -- bufmap("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
  -- bufmap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
  -- bufmap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  bufmap("n", "<space>D", vim.lsp.buf.type_definition)
  -- bufmap("n", "<space>rn", vim.lsp.buf.rename)
  -- bufmap("n", "<space>ca", vim.lsp.buf.code_action)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "<space>f", function()
    vim.lsp.buf.format {
      async = true,
      filter = function(c)
        return c.name ~= "tsserver" and c.name ~= "sumneko_lua"
      end,
    }
  end)

  -- My settings
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  bufmap("n", "<leader>x", vim.lsp.buf.code_action)
  bufmap("n", "ge", function()
    vim.lsp.diagnostic.show(nil, 0)
  end)
  bufmap("n", "<leader>r", vim.lsp.buf.rename)

  -- print("LSP Attached.")
end

local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = lsp_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

lspconfig.bashls.setup {}
lspconfig.clangd.setup {}
lspconfig.gopls.setup {}
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        black = { enabled = true },
      },
    },
  },
}

lspconfig.rust_analyzer.setup {
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      rustfmt = {
        extraArgs = { "+nightly" },
      },
    },
  },
}
lspconfig.lua_ls.setup {
  cmd = {
    os.getenv("HOME") .. "/src/build/lua-language-server/bin/lua-language-server",
  },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        -- Vim + Busted
        globals = { "vim", "describe", "it", "pending", "before_each" },
      },
    },
  },
}
lspconfig.texlab.setup {}
lspconfig.tsserver.setup {}
lspconfig.vimls.setup {}

--------------------------------
----------- Null-ls ------------
--------------------------------
local null_ls = require("null-ls")
null_ls.setup {
  on_attach = lsp_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier.with {
      filetypes = { "html", "css", "scss", "json", "yaml" },
    },
  },
}

--------------------------------
------ Zettelkasten notes ------
--------------------------------
require("zk").setup { picker = "fzf", lsp = { config = { on_attach = lsp_attach } } }

local function zk_link(after)
  require("zk").pick_notes({}, { title = "Zk Insert Link" }, function(notes)
    vim.schedule(function()
      for _, note in ipairs(notes) do
        -- strip off extension
        local link = "[" .. note.title .. "](" .. note.path:sub(1, -4) .. ")"
        vim.api.nvim_put({ link }, "c", after, true)
      end
    end)
  end)
end

require("zk.commands").add("ZkLink", function(options) end)

cmd("command! ZkEdit FloatermNew ZK_EDITOR=floaterm zk edit --interactive")
map("n", "<leader>n", "<cmd>ZkEdit<cr>")
map("v", "<leader>n", "<cmd>'<,'>ZkNewFromTitleSelection<cr>")
map("n", "<leader>m", function()
  zk_link(true)
end)
map("n", "<leader>M", function()
  zk_link(false)
end)

--------------------------------
---------- TreeSitter ----------
--------------------------------
require("nvim-treesitter.configs").setup {
  -- No `ensure_installed` I manually install language parsers, since verifying
  -- is really slow on WSL
  highlight = {
    enable = true,
  },
}

-- cmd([[autocmd OptionSet binary echo 'hi']])
-- cmd([[autocmd VimEnter if &binary | echo 'hi' | endif]])
