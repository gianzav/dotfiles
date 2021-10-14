lua << EOF
require'lspconfig'.clangd.setup{}
EOF

" Commands:
" - ClangdSwitchSourceHeader: Switch between source/header

" Default Values:
"   capabilities = default capabilities, with offsetEncoding utf-8
"   cmd = { "clangd", "--background-index" }
"   filetypes = { "c", "cpp", "objc", "objcpp" }
"   on_init = function to handle changing offsetEncoding
"   root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
    
:command! Proto :normal gg/prototype<CR>jV}y/main<CR>f{%o<CR><ESC>pV}:s/;$/ {/* TODO */}/g<CR>
:vnoremap <leader>c :s/\(.*\)/\/\/\1/g<CR>
setlocal commentstring=/*%s*/
