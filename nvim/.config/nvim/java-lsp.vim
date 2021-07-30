" augroup javasnippets
"     autocmd!
"     autocmd FileType java iabbrev <buffer> re return;<ESC>i
"     autocmd FileType java iabbrev <buffer> return USALOSHORTCUT
"     autocmd FileType java inoreabbrev <buffer> main public static void main( String args[] ){}<ESC>i
"     autocmd FileType java setlocal commentstring="/* %s */"
"     autocmd FileType java lua require'lspconfig'.java_language_server.setup{cmd = {"/home/gianluca/repos/java-language-server/dist/launch_linux.sh"}}
" augroup END

lua << EOF
require('jdtls').start_or_attach({
    cmd = {'java-lsp.sh', '/home/gianluca/dev/java/lsp/workspace' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')},
    root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})
    })
EOF

inoreabbrev <buffer> main public static void main(String args[]) {}<ESC>i
setlocal commentstring=/*%s*/ 
" lua require'lspconfig'.java_language_server.setup{cmd = {"/home/gianluca/repos/java-language-server/dist/lang_server_linux.sh"}}
" lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})

" `code_action` is a superset of vim.lsp.buf.code_action and you'll be able to
" use this mapping also with other language servers
nnoremap <A-CR> <Cmd>lua require('jdtls').code_action()<CR>
vnoremap <A-CR> <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
nnoremap <leader>re <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>

nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Cmd>lua require('jdtls').extract_method()<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>


" If using nvim-dap
" This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
" nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
" nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
