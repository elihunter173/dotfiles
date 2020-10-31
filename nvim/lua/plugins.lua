-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, "packadd packer.nvim")

-- TODO: Make this local when https://github.com/wbthomason/packer.nvim/issues/77 is resolved
map = vim.api.nvim_set_keymap

if not packer_exists then
  -- TODO: Maybe handle windows better?
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = vim.fn.stdpath("data") .. "/site/pack/packer/opt/"

  vim.fn.mkdir(directory, "p")
  local out = vim.fn.system(string.format(
      "git clone %s %s",
      "https://github.com/wbthomason/packer.nvim",
      directory .. "/packer.nvim"
    ))
  print(out)
  print("Downloading packer.nvim...")
  return
end

local packer = require("packer")

-- Slightly improve performance
packer.init {
    max_jobs = 5,
}

return packer.startup(function(use)
  -- Packer can manage itself as an optional plugin
  use {"wbthomason/packer.nvim", opt = true}

  -- Base16 colorscheme
  use "chriskempson/base16-vim"
  -- TODO: Take config from init.vim

  -- General editing
  -- Easier commenting for any language
  use "tpope/vim-commentary"
  -- Additional text objects
  use "wellle/targets.vim"
  -- Surrounding text objects with any character
  use "machakann/vim-sandwich"
  -- Nice mappings
  use "tpope/vim-unimpaired"

  -- Configuration stuff
  -- Never think about indentation
  use "tpope/vim-sleuth"
  -- https://EditorConfig.org
  use {
    "editorconfig/editorconfig-vim",
    config = function()
      -- EditorConfig + Fugitive
      vim.g.EditorConfig_exclude_patterns = {"fugitive://.\\*"}
    end,
  }

  -- Enable editing of readonly files using sudo.
  -- Remove when https://github.com/neovim/neovim/pull/10842 gets merged
  use {
    "lambdalisue/suda.vim",
    config = function()
      -- Automatically open readonly files with sudo using suda.vim
      vim.g.suda_smart_edit = 1
    end,
  }

  -- Neovim's CursorHold is a little laggy right now. This fixes that.
  use "antoinemadec/FixCursorHold.nvim"

  -- Nice start screen
  use "mhinz/vim-startify"

  -- Lightweight git wrapper
  -- TODO: Check out Gina.vim
  use {
    "tpope/vim-fugitive",
    config = function()
      --[[
      nnoremap <leader>gs <cmd>Gstatus<CR>
      nnoremap <leader>gp <cmd>Gpush<CR>
      --]]
      map("n", "<leader>gs", "<cmd>Gstatus<CR>", {noremap = true})
      map("n", "<leader>gp", "<cmd>Gpush<CR>", {noremap = true})
    end,
  }

  -- Netrw but simpler and better
  use "justinmk/vim-dirvish"
  -- Disable netrw because I use Dirvish
  vim.g.loaded_netrwPlugin = 1

  -- Syntax highlighting for more languages
  use {
    "plasticboy/vim-markdown",
    -- "sheerun/vim-polyglot",
    -- For :TableFormat in markdown
    requires = "godlygeek/tabular",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_auto_insert_bullets = 0
      vim.g.vim_markdown_new_list_item_indent = 2
      -- LaTeX with no concealing
      vim.g.tex_conceal = ""
      vim.g.vim_markdown_math = 1
    end,
  }

  -- Vim undotree visualizer
  use "mbbill/undotree"

  -- TODO: Can I make fzf a dep?
  -- use {"junegunn/fzf", run = "./install --all" }
  use {
    "junegunn/fzf.vim",
    config = function()
      -- Don't open unnecessary files
      vim.g.fzf_buffers_jump = 1
      vim.g.fzf_layout = { window = { width = 0.85, height = 0.8 } }
      vim.g.fzf_preview_window = ""

      --[[
      nnoremap <leader>o <cmd>Buffers<CR>
      nnoremap <leader>O <cmd>Files<CR>
      nnoremap <leader>h <cmd>BLines<CR>
      nnoremap <leader>H <cmd>Rg<CR>
      --]]
      -- Nice keybindings
      map("n", "<leader>o", "<cmd>Buffers<CR>", {noremap = true})
      map("n", "<leader>O", "<cmd>Files<CR>", {noremap = true})
      map("n", "<leader>h", "<cmd>BLines<CR>", {noremap = true})
      map("n", "<leader>H", "<cmd>Rg<CR>", {noremap = true})
    end,
  }

  -- Floating terminal
  use {
    "voldikss/vim-floaterm",
    config = function()
      map("n", "<leader>t", "<cmd>FloatermToggle<CR>", {noremap = true})
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
  }

  -- TODO: Migrate full config over
  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = { "nvim-lua/completion-nvim", "nvim-lua/diagnostic-nvim" },
    config = function()
      local nvim_lsp = require("nvim_lsp")
      local nvim_completion = require("completion")
      local nvim_diagnostic = require("diagnostic")

      local custom_attach = function()
        nvim_completion.on_attach()
        nvim_diagnostic.on_attach()

        --[[
        nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
        inoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
        nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
        nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
        nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
        nnoremap <silent> g0        <cmd>lua vim.lsp.buf.document_symbol()<CR>
        nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
        nnoremap <silent> ge        <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
        nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>
        --]]
        map("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {silent = true, noremap = true})
        map("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", {silent = true, noremap = true})
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true, noremap = true})
        map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", {silent = true, noremap = true})
        map("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {silent = true, noremap = true})
        map("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {silent = true, noremap = true})
        map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {silent = true, noremap = true})
        map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {silent = true, noremap = true})
        map("n", "<leader>r", "cmd>lua vim.lsp.buf.rename()<CR>", {silent = true, noremap = true})
        map("n", "<leader>f", "cmd>lua vim.lsp.buf.formatting()<CR>", {silent = true, noremap = true})
        map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {silent = true, noremap = true})
        map("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {silent = true, noremap = true})
        map("n", "ge", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>", {silent = true, noremap = true})
        map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", {silent = true, noremap = true})

        --[[
        nnoremap ]d <cmd>NextDiagnostic<CR>
        nnoremap [d <cmd>PrevDiagnostic<CR>
        --]]
        map("n", "]d", "<cmd>NextDiagnostic<CR>", {noremap = true})
        map("n", "[d", "<cmd>PrevDiagnostic<CR>", {noremap = true})

        print("LSP Attached.")
      end

      nvim_lsp.pyls.setup{ on_attach = custom_attach }
      nvim_lsp.jdtls.setup{ on_attach = custom_attach }

      nvim_lsp.vimls.setup{ on_attach = custom_attach }
      nvim_lsp.sumneko_lua.setup {
        cmd = { vim.fn.stdpath("cache") .. "/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", vim.fn.stdpath("cache") .. "/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
        on_attach = custom_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }

      nvim_lsp.yamlls.setup{ on_attach = custom_attach }
      nvim_lsp.bashls.setup{ on_attach = custom_attach }

      nvim_lsp.texlab.setup{ on_attach = custom_attach }

      nvim_lsp.clangd.setup{ on_attach = custom_attach }
      nvim_lsp.rust_analyzer.setup{ on_attach = custom_attach }
    end,
  }
  --

  -- A nice tagbar for LSP
  use {
    "liuchengxu/vista.vim",
    config = function()
      -- Pretty icons don't work everywhere and are idiosyncratic IMO
      vim.g["vista#renderer#enable_icon"] = 0
      vim.g.vista_fold_toggle_icons = {"-", "+"}
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter-refactor",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- one of "all", "language", or a list of languages
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
      }

      --[[
      nnoremap S <cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<CR>
      --]]
      map("n", "S", "<cmd>lua require'nvim-treesitter-refactor.highlight_definitions'.highlight_usages(vim.fn.bufnr())<CR>", {noremap = true, silent = true})
      end,
  }

end)
