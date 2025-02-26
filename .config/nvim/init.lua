local g, opt, map, autocmd = vim.g, vim.opt, vim.keymap.set, vim.api.nvim_create_autocmd

-- Faster load time
vim.loader.enable()

-- Make sure to set `mapleader` before lazy so your mappings are correct
g.mapleader = " "

-----------------------------
---------- Plugins ----------
-----------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  -- Markdown
  {
    "plasticboy/vim-markdown",
    dependencies = "godlygeek/tabular",
    ft = "markdown",
  },
  -- Easier commenting for any language
  "numToStr/Comment.nvim",
  -- Additional text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- TODO: In rust this is not just definition
              ["as"] = "@class.outer",
              ["is"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              -- You can also use captures from other query groups like `locals.scm`
              -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@function.outer"] = "V",
              ["@function.inner"] = "V",
              ["@class.outer"] = "V",
              ["@class.inner"] = "V",
              ["@parameter.outer"] = "v",
              ["@parameter.inner"] = "v",
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              -- ["]s"] = { query = "@class.outer", desc = "Next class start" },
              ["]a"] = "@parameter.outer",
              -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]S"] = "@class.outer",
              ["]A"] = "@parameter.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              -- ["[s"] = "@class.outer",
              ["[a"] = "@parameter.outer",
              -- ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[S"] = "@class.outer",
              ["[A"] = "@parameter.outer",
            },
          },
        },
      }
    end
  },
  -- Surrounding text objects with any characte
  { "echasnovski/mini.surround", version = false, config = function()
    require("mini.surround").setup()
  end },
  -- Vim undotree visualizer
  "mbbill/undotree",
  -- Never think about indentation
  "tpope/vim-sleuth",
  -- https://EditorConfig.org
  "editorconfig/editorconfig-vim",
  -- Git
  "tpope/vim-fugitive",
  { "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
  -- Multi-cursor
  -- TODO: Check out https://github.com/smoka7/multicursors.nvim
  "mg979/vim-visual-multi",
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      local set = vim.keymap.set
      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
      set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
      set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
      set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

      -- In normal/visual mode, press `mwap` will create a cursor in every match of
      -- the word captured by `iw` (or visually selected range) inside the bigger
      -- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
      -- This is short for mWiwXX
      set({ "n", "x" }, "mw", function()
        mc.operator({ motion = "iw", visual = true })
        -- Or you can pass a pattern, press `mwi{` will select every \w,
        -- basically every char in a `{ a, b, c, d }`.
        -- mc.operator({ pattern = [[\<\w]] })
      end)

      -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
      set("n", "mW", mc.operator)

      -- Add all matches in the document
      set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

      -- You can also add cursors with any motion you prefer:
      -- set("n", "<right>", function()
      --     mc.addCursor("w")
      -- end)
      -- set("n", "<leader><right>", function()
      --     mc.skipCursor("w")
      -- end)

      -- Rotate the main cursor.
      set({ "n", "x" }, "<left>", mc.nextCursor)
      set({ "n", "x" }, "<right>", mc.prevCursor)

      -- Delete the main cursor.
      set({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)

      -- Easy way to add and remove cursors using the main cursor.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Clone every cursor and disable the originals.
      set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- bring back cursors if you accidentally clear them
      set("n", "<leader>gv", mc.restoreCursors)

      -- Align cursor columns.
      set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex.
      set("x", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections.
      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)

      -- match new cursors within visual selections by regex.
      set("x", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      set("x", "<leader>t", function() mc.transposeCursors(1) end)
      set("x", "<leader>T", function() mc.transposeCursors(-1) end)

      -- Jumplist support
      set({ "x", "n" }, "<c-i>", mc.jumpForward)
      set({ "x", "n" }, "<c-o>", mc.jumpBackward)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
  },
  -- Indent marks
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("ibl").setup() end,
  },
  -- The file manager I made
  "elihunter173/dirbuf.nvim",
  -- Fuzzy finding
  {
    "junegunn/fzf",
    "junegunn/fzf.vim",
    run = function()
      vim.fn["fzf#install"]()
    end,
  },
  -- Justfile support
  "NoahTheDuke/vim-just",

  { "yorickpeterse/nvim-pqf",  config = function() require('pqf').setup() end },
  {
    "gabrielpoca/replacer.nvim",
    config = function()
      vim.api.nvim_create_user_command("QfReplace", require("replacer").run, {})
    end,
  },

  -- LSP and autocomplete
  "neovim/nvim-lspconfig",
  {
    "mrcjkb/rustaceanvim",
    version = '^5',
    -- This plugin is already lazy
    lazy = false,
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        sources = { { name = "nvim_lsp" }, { name = 'luasnip' } },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        -- TODO: Look into new mappings
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Insert },
        },
      }
    end,
  },

  -- TreeSitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}

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
autocmd("FileType", { pattern = { "markdown,text" }, command = "setlocal spell wrap linebreak breakindent" })
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

-- My global namespace
eli = {}

local function longest_common_prefix(strs)
  if #strs == 0 then return "" end

  for i = 1, #strs[1] do
    local char = strs[1]:sub(i, i)
    for j = 2, #strs do
      if i > #strs[j] or strs[j]:sub(i, i) ~= char then
        return strs[1]:sub(1, i - 1)
      end
    end
  end

  return strs[1]
end

local function suggest_name(bufnames)
  local common_prefix = longest_common_prefix(bufnames)
  -- Try to shorten using well known locations
  local well_known_locations = { { vim.fn.getcwd(), "" }, { vim.fn.expand("~"), "~" } }
  for _, path_replace in ipairs(well_known_locations) do
    local path, replace = table.unpack(path_replace)
    local shorter = common_prefix:gsub("^" .. vim.pesc(path), replace)
    if #shorter < #common_prefix then
      return shorter
    end
  end
  return common_prefix
end

local function suggested_name_for_tab(tab)
  local windows = vim.api.nvim_tabpage_list_wins(tab)
  local names = {}
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname ~= "" then
      table.insert(names, bufname)
    end
  end
  return suggest_name(names)
end

function eli.tabinfo()
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local suggested = suggested_name_for_tab(tab)
    print(string.format("tab %d %s", tab, suggested))
  end
end

-- Returns nil or tab (number)
function eli.parse_tab_line(line)
  -- TODO: This allows "tab 2foo" which I don't like
  local num = line:match("^%s*tab (%d+)")
  if num == nil then
    return nil
  else
    return tonumber(num)
  end
end

-- TODO: Figure out how to do floating window

opt.statusline = "[%{mode()}] %{v:lua.MYFILENAME()}%m%r%w%q%=%l,%c %{get(b:,'gitsigns_head','')}"

-- Colorscheme
opt.termguicolors = os.getenv("TERM") ~= "screen"
opt.background = "dark"

-----------------------------
--------- Mappings ----------
-----------------------------
map("n", "<leader>w", "<cmd>write<cr>")
-- Make leader keybindings less awkward
map({ "n", "v" }, " ", "")

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
-- cmd("autocmd TermOpen * startinsert | setlocal norelativenumber nonumber signcolumn=no")
autocmd({ "TermOpen" }, { pattern = "*", command = "startinsert | setlocal norelativenumber nonumber signcolumn=no" })

-----------------------------
------ Custom Commands ------
-----------------------------
local function gh_copy_permalink(args)
  -- Trim whitespace (i.e. \n) from commit
  local commit = vim.fn.system("git rev-parse HEAD"):gsub("%s+", "")
  local location = vim.fn.expand("%:.")
  if args.range == 0 then
    -- No range, select entire file
  elseif args.range == 1 then
    -- One item in range, select that line
    location = string.format("%s:%d", location, args.line1)
  else
    -- Two items in range, select that range
    location = string.format("%s:%d-%d", location, args.line1, args.line2)
  end
  local permalink = vim.fn.system(string.format("gh browse '%s' --no-browser --commit=%s", location, commit))
      :gsub("%s+", "")
      :gsub("?plain=1", "") -- This just looks ugly imo
  vim.fn.setreg("+", permalink)
  print("Copied", permalink)
end

vim.api.nvim_create_user_command("GhCopy", gh_copy_permalink, { range = 1 })

-----------------------------
------- Plugin Config -------
-----------------------------
-- Colorscheme
local gruvbox = require("gruvbox")
gruvbox.setup {
  italic = { strings = false },
  overrides = {
    -- Make indent-blankline scope brighter
    IblScope = { fg = gruvbox.palette.gray },
    -- SignColumn = bg0
    SignColumn = { bg = gruvbox.palette.dark0 },
  }
}
vim.cmd("colorscheme gruvbox")

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
autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.bazel", command = "set filetype=python" })

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
vim.cmd([[
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
-- Recommended diagnostic settings
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
map("n", "<leader>d", function() vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR }) end)

local function lsp_attach(client, bufnr)
  local function bufmap(mode, lhs, rhs)
    map(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  -- TODO: Maybe I find the LSP syntax highlighting annoying?
  client.server_capabilities.semanticTokensProvider = nil

  -- Recommended LSP settings
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  bufmap("n", "gD", vim.lsp.buf.declaration)
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  bufmap("n", "K", vim.lsp.buf.hover)
  bufmap("n", "<space>D", vim.lsp.buf.type_definition)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "<space>f", function()
    vim.lsp.buf.format {
      -- async = true,
      filter = function(c)
        return c.name ~= "sumneko_lua"
      end,
    }
  end)

  -- My settings
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  bufmap("n", "g.", vim.lsp.buf.code_action)
  bufmap("n", "<leader>r", vim.lsp.buf.rename)

  print(client.name .. " attached")
end

local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = lsp_attach,
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
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

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      lsp_attach(client, bufnr)

      -- Overrides
      local function bufmap(mode, l, r, opts)
        opts = vim.tbl_extend("force", { buffer = bufnr, silent = true }, opts or {})
        vim.keymap.set(mode, l, r, opts)
      end

      -- Grouped code actions
      bufmap("n", "g.", function()
        vim.cmd.RustLsp("codeAction")
      end)
      -- Longer errors
      -- bufmap("n", "<leader>e", function()
      --   vim.cmd.RustLsp("renderDiagnostic")
      -- end)
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        server = {
          path = "/Users/eli.hunter/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer",
        },
        rustfmt = {
          extraArgs = { "+nightly-2024-11-28" },
        },
        cargo = {
          features = "all",
        },
        references = { excludeTests = true },
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

lspconfig.lua_ls.setup {
  cmd = {
    os.getenv("HOME") .. "/src/lua-language-server/bin/lua-language-server",
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

--------------------------------
---------- TreeSitter ----------
--------------------------------
require("nvim-treesitter.configs").setup {
  ensure_installed = { "rust", "toml", "lua", "go", "python" },
  -- No `ensure_installed` I manually install language parsers, since verifying
  -- is really slow on WSL
  highlight = {
    enable = true,
  },
}
