HOME = os.getenv("HOME")


function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end


function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end


-- vim.opt.runtimepath:prepend(HOME .. "/.config/nvim")
-- vim.opt.runtimepath:append(HOME .. "/.vim/after")
-- vim.g.packpath = vim.opt.runtimepath
-- add every directory and subdirectory to search path (fuzzy file finding)
vim.opt.path:append("**")

vim.g.mapleader = " "

-- set the background color for seoul256 colorscheme
vim.g.seoul256_background = 236


-- VIM-LATEX-LIVE-PREVIEW VARIABLES
-- document viewer for latex preview
vim.g.livepreview_previewer = "zathura"
vim.g.tex_flavor = "latex"

-- ULTISNIPS VARIABLES
-- setting <tab> key to activate the snippets
-- vim.g.UltiSnipsExpandTrigger = "<f5>"        --Do not use <tab>
-- vim.g.UltiSnipsJumpForwardTrigger = "<tab>"  --Do not use <c-j>

-- setting the snippets folder where UltiSnips searches
-- vim.g.UltiSnipsSnippetDirectories = HOME .. "/.config/nvim/mysnippets/"

-- Start netrw in 'tree' style
vim.g.netrw_liststyle = 3
-- When in netrw, open files in the editing buffer (previous window)
vim.g.netrw_browse_split = 4

-- Prevent AutoPairs to insert a double space into brackets/parentheses
vim.g.AutoPairsMapSpace = 0

-- Do not conceal special markdown characters
-- vim.g.pandoc#syntax#conceal#use = 0


require "paq" {
     "savq/paq-nvim";                  -- Let Paq manage itself
     "jiangmiao/auto-pairs";
     "tpope/vim-surround";
    --  "xuhdev/vim-latex-live-preview", { "for": "tex" }
    --  "lervag/vimtex"
    --  "junegunn/goyo.vim"
     "vim-pandoc/vim-pandoc-syntax";
    --  "neoclide/coc.nvim", {"branch": "release"}
     "preservim/tagbar";
     "junegunn/seoul256.vim";
    {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"};  -- We recommend updating the parsers on update
     "tpope/vim-commentary";
    --  "mfussenegger/nvim-jdtls"
     "neovim/nvim-lspconfig";
     "williamboman/nvim-lsp-installer";
     "folke/lsp-colors.nvim";
     "ray-x/lsp_signature.nvim";
     "tpope/vim-fugitive";
     "tpope/vim-repeat";

    -- nvim-cmp
     "hrsh7th/cmp-nvim-lsp";
     "hrsh7th/cmp-buffer";
     "hrsh7th/cmp-path";
     "hrsh7th/cmp-cmdline";
     "hrsh7th/nvim-cmp";

    -- Using telescope instead of fzf?
     "nvim-lua/plenary.nvim";
     "nvim-telescope/telescope.nvim"
}


require("nvim-lsp-installer").setup {}
--require'lspconfig'.pyright.setup{} called in nvim-cmp-config
--require'lspconfig'.sumneko_lua.setup{} called in nvim-cmp-config
require'lsp_signature'.setup()
require'nvim-cmp-config'

vim.cmd([[
    augroup python
    autocmd!
    autocmd FileType python source HOME/.config/nvim/lsp.vim
    augroup END
]])

vim.cmd([[
    augroup clang
    autocmd!
    autocmd FileType c,cpp source HOME/.config/nvim/lsp.vim
    " autocmd FileType c,cpp source HOME/.config/nvim/nvim-clangd.vim

]])

vim.cmd([[
    augroup java
    autocmd!
    autocmd FileType java source HOME/.config/nvim/lsp.vim
    " autocmd FileType java source HOME/.config/nvim/java-lsp.vim

]])

vim.cmd([[
    augroup lua
    autocmd!
    autocmd BufNewFile,BufRead *.love setlocal filetype=lua
    autocmd BufNew,BufAdd,BufReadPre,BufNewFile,BufRead *.lua lua require'sumneko_lua'
    augroup END

]])

vim.cmd([[
    augroup js
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js source HOME/.config/nvim/lsp.vim
    " autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js lua require'lspconfig'.tsserver.setup{}

]])

vim.cmd([[
    augroup haskell
    autocmd!
    autocmd BufNewFile,BufRead  *.x set filetype=haskell
    autocmd BufNewFile,BufRead  *.y set filetype=haskell
    autocmd Filetype haskell command! RunGhc w | !runghc %
    autocmd Filetype haskell command! -nargs=* Ghci split | term ghci <args>
    augroup END

]])


-- completion basic configuration
vim.opt.completeopt={"menu","menuone","noselect"}

-- MAPPINGS

-- <backspace> to disable highlight
nmap("<BS>", ":nohls<CR>")

-- Y yanks to the end of the line (same logic as D,C,S)
nmap("Y", "y$")

-- Use <Tab> and <S-Tab> to navigate through popup menu for completion
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

-- Telescope config
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- move lines with Alt-j Alt-k
nmap( "<A-j>", ":m .+<CR>")
nmap( "<A-k>", ":m .--<CR>")

-- make the cursor always in the center of window when moving
nmap("j", "jzz")
nmap("k", "kzz")

-- Set a mark when performing a search to jump back
-- nnoremap / mj/

-- Use typical regex to perform a search
vim.api.nvim_set_keymap("n", "/", "/\\v", {})

--open directory tree and set width
nmap("<C-n>", ":Vex<CR>:vertical resize 25<CR>")

-- quickly edit vimrc
nmap("<leader>ev", ":e $MYVIMRC<CR>")

-- source vimrc
nmap("<leader>sv", ":so $MYVIMRC<CR>")

-- change buffer quickly with FZF
nmap("<leader>b", ":Buffers<CR>")

-- jump to next placeholder
nmap("<tab>", "mk/<++><CR>:nohls<CR>cf>")
nmap("<shift><tab>", "mk?<++><CR>:nohls<CR>cf>")

-- jump to next and previous quickfix entry
-- nnoremap <C-k> :cprev<CR>
-- nnoremap <C-j> :cnext<CR>
nmap("<leader>j", ":lnext<CR>")
nmap("<leader>k", ":lprev<CR>")

-- close local and quickfix list
nmap("<leader>cc", ":cclose \\| lclose<CR>")

-- copy and paste easily from system clipboard
vmap("<leader>C", [["+y:echo "copied to clipboard"<CR>]])
nmap("<leader>V", [["+p]])

vim.api.nvim_create_user_command("Copy", [[:norm "+y]], {})
vim.api.nvim_create_user_command("Paste", [[:norm "+p]], {})

-- change into next and last(previous) parentheses
vim.cmd("onoremap n( :<c-u>normal! f(vi(<CR>")
vim.cmd("onoremap l( :<c-u>normal! F(vi(<CR>")

-- Toggle tagbar
nmap("<leader>t", ":TagbarOpen fjc<CR>")

-- Open pdf under cursor
nmap("<leader>o", ":!find $HOME/* -name <cfile> \\| xargs zathura --fork<CR>")

-- exiting from insert mode in terminal with <ESC>
tmap("<ESC>", "<C-\\><C-n>")

-- remapping window command
nmap("<leader>w", "<C-w>")


-- ABBREVIATIONS
vim.cmd("iabbrev lenght length")

-- enabling plugins and tools based on filetypes
vim.cmd("filetype on")

-- filetype plugin on
vim.cmd("filetype indent on")


-- SETS

-- show trailing spaces
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:∙,nbsp:+"


-- allow to open a new buffer if the current is not saved
vim.opt.hidden = true

-- enable the column for signs (left of line numbers)
vim.opt.signcolumn = "yes"

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess = "c"

-- tree-sitter based folding
vim.opt.foldmethod = "manual"
vim.opt.foldexpr= "nvim_treesitter#foldexpr()"

-- disable line wrapping
vim.opt.wrap = false

-- indent based on the line before
vim.opt.autoindent = true
vim.opt.smartindent = true

-- numbered lines, numbering from the current one
vim.opt.number = true
vim.opt.relativenumber = true

-- autocompletion for file names
vim.opt.wildmenu = true
vim.opt.wildmode = "full"

-- syntax highlighting on
vim.opt.syntax = "on"

-- the split screens open on the right and bottom
vim.opt.splitbelow = true
vim.opt.splitright = true

-- tabs as indent of 4 spaces
vim.opt.tabstop = 4 
vim.opt.softtabstop = 4 
vim.opt.shiftwidth = 4 
vim.opt.expandtab = true

-- Highlight matching search patterns
-- set nohls

-- Enable incremental search
vim.opt.incsearch = true

-- Include matching uppercase words with lowercase search term
vim.opt.ignorecase = true
vim.opt.fileignorecase = true

-- Include only uppercase words with uppercase search term
vim.opt.smartcase = true

-- show keypresses in normal mode
vim.opt.showcmd = true

-- start vim in dark colors
vim.cmd("syntax enable")
vim.opt.termguicolors = true
vim.cmd([[colorscheme seoul256]])

-- let the background be transparent
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")

-- disabling comment auto continuing (see :help formatoptions)
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

-- enabling the autoread feature (if a file is changed out of the editor 
-- it reads it again ad refreshes the page
vim.opt.autoread = true

-- highlight cursor line
vim.opt.cursorline = true

-- highlight column 80
vim.opt.colorcolumn = "80"

-- enable mouse in normal and visual mode
vim.opt.mouse = "nv"

-- prevent the windows (like the file split) from being resized automatically
vim.opt.equalalways = false
vim.opt.eadirection = "ver"

-- enable builtin debugging
vim.cmd("packadd termdebug")

-- Custom highlight group, see autocommands below for use
-- highlight MyHl ctermbg=blue guibg=blue

-- USER COMMANDS

-- 'e' flag to ignore the error if the pattern is not found
vim.api.nvim_create_user_command( "SpacedBraces", [[silent :%s/\([(\[{]\)\([^ ].*[^ ]\)\([)\]}]\)/\1 \2 \3/gec | nohls]], {})
vim.api.nvim_create_user_command( "NoSpacedBraces", [[silent :%s/\([(\[{]\) \(.*\) \([)\]}]\)c/\1\2\3/ge | nohls]], {})
vim.api.nvim_create_user_command( "Accents", [[:%s/a'/à/geI | :%s/e'/è/geI | :%s/i'/ì/geI | :%s/o'/ò/geI | :%s/u'/ù/geI
    | %s/À/À/geI | :%s/È/È/geI | :%s/Ì/Ì/geI | :%s/Ò/Ò/geI | :%s/Ù/Ù/geI]], {})
vim.api.nvim_create_user_command( "TabTerm", ":tabe | :term", {})
vim.api.nvim_create_user_command( "TrailSpaces", "%s/ *$//g | :nohls", {})
vim.api.nvim_create_user_command( "SpacedCommas", "%s/,\\([^ ]\\)/, \\1/ge", {})


-- LUA

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
  },
  indent = {
    enable = true
  },
}

-- AUTOCOMMANDS

vim.cmd([[
    augroup html
        autocmd!
        autocmd FileType html inoreabbrev <buffer> p <p></p><ESC>F<h<CR>=Eatchar('\s')<CR><ESC>i
        autocmd FileType html vim.g.AutoPairs['<']='>'
    augroup END
]])

vim.cmd([[
    augroup latex
        autocmd!
        autocmd FileType tex nnoremap <buffer> <leader>p :LLPStartPreview<CR>
    augroup END
]])

vim.cmd([[
    augroup markdown
        autocmd!
        autocmd FileType markdown let g:AutoPairs['<']='>'
        autocmd FileType markdown let g:AutoPairs['$']='$'
        autocmd FileType markdown setlocal textwidth=80
        autocmd FileType markdown nnoremap <buffer> <C-s> :w \| !compile <c-r>%<CR><CR>
        autocmd FileType markdown nnoremap <buffer> <leader>p :w! \| !zathura --fork $(compile <c-r>%)<CR><CR>
        " render only selected lines and open the pdf
        autocmd FileType markdown vnoremap <silent> <leader>p :w! /tmp/tmplines.md<cr>:silent !zathura $(compile /tmp/tmplines.md)<cr>
        autocmd FileType markdown nnoremap <buffer> <F9> :silent !zathura --fork -P 61 HOME/docs/manuals/pandoc_man.pdf<CR>
        autocmd FileType markdown nnoremap <buffer> <F10> :silent !zathura --fork HOME/docs/manuals/latex_math_reference.pdf<CR>
        autocmd FileType markdown setlocal shiftwidth=2
        autocmd BufNewFile,BufFilePre,BufRead *.md setlocal filetype=markdown.pandoc
    augroup END
]])
