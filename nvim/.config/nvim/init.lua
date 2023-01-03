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

vim.g.nvim_ipy_perform_mappings = 0

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
    -- {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"};  -- We recommend updating the parsers on update
    "nvim-treesitter/nvim-treesitter";
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

    -- vsnip for snippets
     "hrsh7th/vim-vsnip";
    -- Using telescope instead of fzf?
     "nvim-lua/plenary.nvim";
     "nvim-telescope/telescope.nvim";

     -- colorschemes
     "junegunn/seoul256.vim";
     "Mofiqul/dracula.nvim";
     "EdenEast/nightfox.nvim";

     -- jupyter and vim integration
     "bfredl/nvim-ipy";

     -- clingo syntax highlight
     "rkaminsk/vim-syntax-clingo";

     "junegunn/goyo.vim"
}


require("nvim-lsp-installer").setup {}
--require'lspconfig'.pyright.setup{} called in nvim-cmp-config
--require'lspconfig'.sumneko_lua.setup{} called in nvim-cmp-config
require'lsp_signature'.setup()
require'nvim-cmp-config'




-- completion basic configuration
vim.opt.completeopt={"menu","menuone","noselect"}

-- MAPPINGS

-- Fire Goyo
nmap("<leader>G", ":silent Goyo 85<CR>:set number relativenumber<CR>")

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
-- nmap("<tab>", "mk/<++><CR>:nohls<CR>cf>")
-- nmap("<shift><tab>", "mk?<++><CR>:nohls<CR>cf>")

-- jump to next and previous quickfix entry
-- nnoremap <C-k> :cprev<CR>
-- nnoremap <C-j> :cnext<CR>
nmap("<leader>j", ":lnext<CR>")
nmap("<leader>k", ":lprev<CR>")

-- close local and quickfix list
nmap("<leader>cc", ":cclose \\| lclose<CR>")

-- copy and paste easily from system clipboard
vmap("<leader>C", [["+y:echo "copied to clipboard"<CR>]])
vmap("ctrl C", [["+y:echo "copied to clipboard"<CR>]])
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

-- open a split terminal
nmap("<leader>T", ":split<CR>:terminal<CR>")



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
vim.cmd([[colorscheme dracula]])

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
-- vim.opt.cursorline = true

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
vim.api.nvim_create_user_command( "Accents", [[:%s/a'\([^']\)/à\1/geI | :%s/e'\([^']\)/è\1/geI | :%s/i'\([^']\)/ì\1/geI | :%s/o'\([^']\)/ò\1/geI | :%s/u'\([^']\)/ù\1/geI
    | %s/A'\([^']\)/À\1/geI | :%s/E'\([^']\)/È\1/geI | :%s/I'\([^']\)/Ì\1/geI | :%s/O'\([^']\)/Ò\1/geI | :%s/U'\([^']\)/Ù\1/geI]], {})
vim.api.nvim_create_user_command( "LatexAccents", [[:%s/à/\\`a/geI | :%s/è/\\`e/geI | :%s/é/\\'e/geI | :%s/ì/\\`i/geI | :%s/ò/\\`o/geI | :%s/ù/\\`u/geI
    | %s/À/À/geI | :%s/È/È/geI | :%s/Ì/Ì/geI | :%s/Ò/Ò/geI | :%s/Ù/Ù/geI]], {})
vim.api.nvim_create_user_command( "ReverseLatexAccents", [[:%s/\\`a/à/geI | :%s/\\`e/è/geI | :%s/\\'e/é/geI | :%s/\\`i/ì/geI | :%s/\\`o/ò/geI | :%s/\\`u/ù/geI
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

-- Helper function to create augroups
-- name: string, name of the group
-- commands: list of couples {{events that trigger the command}, command}
function augroup_helper(name, autocommands)
    local group_id = vim.api.nvim_create_augroup(name, {})
    vim.api.nvim_clear_autocmds({group = group_id})

    for _,aucmd in pairs(autocommands) do
        aucmd[2].group = group_id
        vim.api.nvim_create_autocmd(aucmd[1], aucmd[2])
    end

    return group_id
end


html_augroup = augroup_helper("html", {
    {{"FileType"}, { pattern = "html", command = "vim.g.AutoPairs['<']='>'" }},
})

latex_augroup = augroup_helper("latex", {
        {{"FileType"}, {pattern = "tex", command = "nnoremap <buffer> <leader>p :LLPStartPreview<CR>"}},
        {{"FileType"}, {pattern = "tex", command = "nnoremap <buffer> <C-s> :Accents<CR>:w<CR>:!pdflatex %<CR>"}},
})

markdown_augroup = augroup_helper("markdown", {
         {{"FileType"}, {pattern = "markdown", command = "let g:AutoPairs['<']='>'"}},
         {{"FileType"}, {pattern = "markdown", command = "let g:AutoPairs['$']='$'"}},
         {{"FileType"}, {pattern = "markdown", command = "setlocal textwidth=80"}},
         {{"FileType"}, {pattern = "markdown", command = "nnoremap <buffer> <C-s> :w \\| !compile <c-r>%<CR><CR>"}},
         {{"FileType"}, {pattern = "markdown", command = "nnoremap <buffer> <leader>p :w! \\| !zathura --fork $(compile <c-r>%)<CR><CR>"}},
         {{"FileType"}, {pattern = "markdown", command = "vnoremap <silent> <leader>p :w! /tmp/tmplines.md<cr>:silent !zathura $(compile /tmp/tmplines.md)<cr>"}},
         {{"FileType"}, {pattern = "markdown", command = "nnoremap <buffer> <F9> :silent !zathura --fork -P 61 HOME/docs/manuals/pandoc_man.pdf<CR>"}},
         {{"FileType"}, {pattern = "markdown", command = "nnoremap <buffer> <F10> :silent !zathura --fork HOME/docs/manuals/latex_math_reference.pdf<CR>"}},
         {{"FileType"}, {pattern = "markdown", command = "setlocal shiftwidth=2"}},
         {{"FileType"}, {pattern = "markdown", command = "inoremap perche' perché"}},
         {{"BufNewFile","BufFilePre","BufRead"},{ pattern = "*.md", command = "setlocal filetype=markdown.pandoc"}},
})

python_augroup = augroup_helper("python", {
    {{"FileType"}, {pattern = "python", command = "source " .. HOME .. "/.config/nvim/lsp.vim"}},
})

clang_augroup = augroup_helper("clang", {
    {{"FileType"},{pattern = {"c", "cpp"}, command = "source" .. HOME .. "/.config/nvim/lsp.vim"}},
})

java_augroup = augroup_helper("java", {
    {{"FileType"},{pattern = "java", command = "source" .. HOME .. "/.config/nvim/lsp.vim"}},
})

lua_augroup = augroup_helper("lua", {
    {{"BufNewFile","BufRead"}, {pattern = "*.love", command =  "setlocal filetype=lua"}},
    {{"BufNew","BufAdd","BufReadPre","BufNewFile","BufRead"}, {pattern =  "*.lua", command = "lua require'sumneko_lua'"}},
})

js_augroup = augroup_helper("js", {
    {{"BufNewFile","BufFilePre","BufRead","BufReadPre"}, {pattern = "*.js", command = "source $HOME/.config/nvim/lsp.vim"}},
})

haskell_augroup = augroup_helper("haskell", {
    {{"BufNewFile","BufRead"}, {pattern = "*.x", command = "set filetype=haskell"}},
    {{"BufNewFile","BufRead"}, {pattern = "*.y", command = "set filetype=haskell"}},
    {{"Filetype"}, {pattern = "haskell", command = "command! RunGhc w | !runghc %"}},
    {{"Filetype"}, {pattern = "haskell", command = "command! -nargs=* Ghci split | term ghci <args>"}},
    {{"Filetype"}, {pattern = "haskell", command = "set shiftwidth=8 tabstop=9 softtabstop=8"}},
})


erlang_augroup = augroup_helper("erlang", {
    {{"Filetype"}, {pattern = "erlang", command = "command! -nargs=* Erl split | term erl <args>"}},
})


-- Use jupyter with vim
-- function ConnectToPipenvKernel()
--   local kernel = vim.fn.system('echo "ipykernel_$(basename "$(pwd)")" | tr -d "\n"')
--   vim.fn.IPython('--kernel' .. kernel .. '--no-window')
-- end

vim.cmd([[
function! ConnectToPipenvKernel()
  let l:kernel = system('echo "ipykernel_$(basename "$(pwd)")" | tr -d "\n"')
  call IPyConnect('--kernel', l:kernel, '--no-window')
endfunction
]])

vim.api.nvim_create_user_command( "RunQtConsole", 'call jobstart("jupyter qtconsole --style=dracula --JupyterWidget.include_other_output=True")', {})

vim.g.ipy_celldef = '^##' -- regex for cell start and end

nmap("<leader>jqt", ":RunQtConsole<Enter>")
nmap("<leader>jk", ":ConnectToPipenvKernel<Enter>")
nmap("<leader>jc", "<Plug>(IPy-RunCell)")
nmap("<leader>ja", "<Plug>(IPy-RunAll)")
