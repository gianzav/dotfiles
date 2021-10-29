set runtimepath^=~/.config/nvim 
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" add coc bindings and settings
" source ~/.config/nvim/coc.vim

" add every directory and subdirectory to search path (fuzzy file finding)
set path+=**

let mapleader = " "

" set the background color for seoul256 colorscheme
let g:seoul256_background = 236


" VIM-LATEX-LIVE-PREVIEW VARIABLES
" document viewer for latex preview
let g:livepreview_previewer = 'zathura'
let g:tex_flavor = "latex"

" ULTISNIPS VARIABLES
" setting <tab> key to activate the snippets
let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<tab>"  " Do not use <c-j>

" setting the snippets folder where UltiSnips searches
let g:UltiSnipsSnippetDirectories = ["~/.config/nvim/mysnippets/"]

" Start netrw in 'tree' style
let g:netrw_liststyle = 3

" Prevent AutoPairs to insert a double space into brackets/parentheses
let g:AutoPairsMapSpace = 0


call plug#begin('~/.config/nvim/plugged')

" Plug 'lifepillar/vim-mucomplete'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
" Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
" Plug 'junegunn/goyo.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/tagbar'
Plug 'junegunn/seoul256.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'tpope/vim-fugitive'
Plug 'yonlu/omni.vim'
Plug 'tpope/vim-repeat'
Plug 'dbeniamine/cheat.sh-vim'

call plug#end()

augroup shell
    autocmd!
    autocmd FileType sh compiler shellcheck
    autocmd BufWritePost <buffer> make %
augroup END

augroup clang
    autocmd!
    autocmd FileType c,cpp source ~/.config/nvim/lsp.vim
    autocmd FileType c,cpp source ~/.config/nvim/nvim-clangd.vim
    autocmd FileType c,cpp lua require'completion'.on_attach()
    autocmd FileType c,cpp lua require'lsp_signature'.setup()
augroup END

augroup java
    autocmd!
    autocmd FileType java source ~/.config/nvim/lsp.vim
    autocmd FileType java source ~/.config/nvim/java-lsp.vim
    autocmd FileType java lua require'completion'.on_attach()
    autocmd FileType java lua require'lsp_signature'.setup()
augroup END

augroup lua
    autocmd!
    autocmd BufNewFile,BufRead *.love set filetype=lua
    autocmd BufNew,BufAdd,BufReadPre,BufNewFile,BufRead *.lua lua require'sumneko_lua'
    autocmd FileType lua source ~/.config/nvim/lsp.vim
    autocmd FileType lua lua require'completion'.on_attach()
    autocmd FileType lua lua require'lsp_signature'.setup()
augroup END

augroup js
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js source ~/.config/nvim/lsp.vim
    autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js lua require'lspconfig'.tsserver.setup{}
    autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js lua require'lsp_signature'.setup()
    autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js lua require'completion'.on_attach()
    autocmd BufNewFile,BufFilePre,BufRead,BufReadPre *.js lua require'lsp_signature'.setup()
augroup END


" source ~/.config/nvim/mucomplete.vim

lua << EOF
vim.lsp.set_log_level('debug')
EOF

" mucomplete configuration
set completeopt=menuone
set completeopt+=noselect
set completeopt+=noinsert
" let g:mucomplete#enable_auto_startup = 1

" MAPPINGS

" Y yanks to the end of the line (same logic as D,C,S)
nnoremap Y y$

" Use <Tab> and <S-Tab> to navigate through popup menu for completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Search files with fzf
nnoremap <silent> <C-p> :Files<CR>

" move lines with Alt-j Alt-k
nnoremap <silent> <A-j> :m .+<CR>
nnoremap <silent> <A-k> :m .--<CR>

" make the cursor always in the center of window when moving
nnoremap j jzz
nnoremap k kzz

" Set a mark when performing a search to jump back
" nnoremap / mj/

" Use typical regex to perform a search
nnoremap / /\v

"open directory tree and set width
nnoremap <C-n> :Vex<CR>:vertical resize 25<CR>

" quickly edit vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>

" source vimrc
nnoremap <leader>sv :so $MYVIMRC<CR>

" change buffer quickly with FZF
nnoremap <leader>b :Buffers<CR>

" start goyo for zenmode
nnoremap <leader>g :Goyo 90<CR>:set textwidth=80<CR>

" jump to next placeholder
 nnoremap <C-l> mk/<++><CR>:nohls<CR>cf>
 nnoremap <C-h> mk?<++><CR>:nohls<CR>cf>

" jump to next and previous quickfix entry
nnoremap <C-k> :cprev<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <leader>j :lnext<CR>
nnoremap <leader>k :lprev<CR>

" close local and quickfix list
nnoremap <leader>cc :cclose \| lclose<CR>

" copy and paste easily from system clipboard
vnoremap <leader>C "+y:echo "copied to clipboard"<CR>
nnoremap <leader>V "+p

" change into next and last(previous) parentheses
onoremap n( :<c-u>normal! f(vi(<CR>
onoremap l( :<c-u>normal! F(vi(<CR>

" Toggle tagbar
nnoremap <leader>t :TagbarOpen fjc<CR>

" Open pdf under cursor
nnoremap <leader>o :!find $HOME/* -name <cfile> \| xargs zathura --fork<CR>

" exiting from insert mode in terminal with <ESC>
tnoremap <ESC> <C-\><C-n>

" remapping window command
nnoremap <leader>w <C-w>


" ABBREVIATIONS
iabbrev lenght length

" enabling plugins and tools based on filetypes
filetype on

" filetype plugin on
filetype indent on


" SETS

" allow to open a new buffer if the current is not saved
set hidden

" enable the column for signs (left of line numbers)
set signcolumn=yes

" Don't pass messages to |ins-completion-menu|.
set shortmess=c

" tree-sitter based folding
set foldmethod=manual
set foldexpr=nvim_treesitter#foldexpr()

" disable line wrapping
set nowrap

" indent based on the line before
set autoindent 
set smartindent

" numbered lines, numbering from the current one
set number relativenumber

" autocompletion for file names
set wildmenu
set wildmode=full

" syntax highlighting on
set syntax=on

" the split screens open on the right and bottom
set splitbelow splitright

" tabs as indent of 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab 

" Highlight matching search patterns
" set nohls

" Enable incremental search
set incsearch

" Include matching uppercase words with lowercase search term
set ignorecase
set fileignorecase

" Include only uppercase words with uppercase search term
set smartcase

" show keypresses in normal mode
set showcmd

" start vim in dark colors
syntax enable
set termguicolors
colorscheme seoul256

" let the background be transparent
hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE

" disabling comment auto continuing (see :help formatoptions)
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o

" enabling the autoread feature (if a file is changed out of the editor 
" it reads it again ad refreshes the page
set autoread

" highlight cursor line
set cursorline

" highlight column 80
set colorcolumn=80

" enable mouse in normal and visual mode
set mouse=nv

" prevent the windows (like the file split) from being resized automatically
set noequalalways
set eadirection=ver

" enable builtin debugging
packadd termdebug

" Custom highlight group, see autocommands below for use
" highlight MyHl ctermbg=blue guibg=blue

" USER COMMANDS

" 'e' flag to ignore the error if the pattern is not found
command! SpacedBraces :%s/(\([^ ].*[^ ]\))/( \1 )/ge
command! NoSpacedBraces :%s/( \(.*\) )/(\1)/ge
command! Accents :%s/a'/à/geI | :%s/e'/è/geI | :%s/i'/ì/geI | :%s/o'/ò/geI | :%s/u'/ù/geI
            \ | %s/À/À/geI | :%s/È/È/geI | :%s/Ì/Ì/geI | :%s/Ò/Ò/geI | :%s/Ù/Ù/geI



" LUA

lua <<EOF
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
EOF

" AUTOCOMMANDS
command! TabTerm :tabe | :term
command! TrailSpaces %s/ *$//g | :nohls

func! Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

augroup html
    autocmd!
    autocmd FileType html :inoreabbrev <buffer> p <p></p><ESC>F<h<CR>=Eatchar('\s')<CR><ESC>i
augroup END

augroup latex
    autocmd!
    autocmd FileType tex :nnoremap <leader>p :LLPStartPreview<CR>
augroup END

augroup markdown
    autocmd!
    autocmd FileType markdown set textwidth=80
    autocmd FileType markdown :nnoremap <C-s> :w \| !compile <c-r>%<CR><CR>
    autocmd FileType markdown :nnoremap <leader>p :w! \| !zathura --fork $(compile <c-r>%)<CR><CR>
    autocmd FileType markdown :nnoremap <F9> :silent !zathura --fork -P 61 ~/docs/manuals/pandoc_man.pdf<CR>
    autocmd FileType markdown :nnoremap <F10> :silent !zathura --fork ~/docs/manuals/latex_math_reference.pdf<CR>
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
