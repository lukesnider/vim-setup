" Always set the working directory to the current file's directory
autocmd BufEnter * silent! lcd %:p:h
let g:netrw_keepdir=0

" Search
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch

" Display
syntax on
set showcmd " Show selection length in ruler
set ruler
set colorcolumn=80
set completeopt-=preview

" Enable matchit
filetype plugin on
runtime macros/matchit.vim

" Enable wildmenu
if has("wildmenu")
    set wildmenu
endif

" Indenting
filetype plugin indent on
set autoindent
set copyindent
set tabstop=8 expandtab shiftwidth=4 softtabstop=4

" Diable annoying audio bell
set visualbell

" Backspace
set backspace=indent,eol,start

" GVim
if has("gui_running")
    "colorscheme slate
    colorscheme gruvbox
    set background=dark

    set guioptions-=T " Disable the toolbar
    set columns=120 lines=40

    if has("macunix")
        set guifont=DejaVu\ Sans\ Mono:h14
    else
        set guifont=DejaVu\ Sans\ Mono\ 14px
    endif
    set linespace=5
end

" Save temp files in a global directory
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

" Windows Fixes
"set guifont=dejavu_sans_mono:h10.5:w6 " Use pretty font

" Source .vimrc after saving it
if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif



" KEY MAPPINGS ===============================================================
" Clear hlsearch with backspace
nnoremap <backspace> :noh<CR>:<backspace>

" Map <Enter> to insert a new empty line above the current line
nnoremap <CR> O<Esc>
" But in the quickfix list, let Enter still behave normally
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Map <Space> to insert a space before the current character
nnoremap <Space> i <Esc>

" Refresh several things with F5
" (ctrp.vim, vim-signify, syntax highlighting weirdness)
nnoremap <F5> :CtrlPClearCache<CR>:SignifyRefresh<CR>:syntax sync fromstart<CR>

" Pretty-print JSON with \j. Works on a selection or a whole buffer.
nnoremap <leader>j :%!python -m json.tool<CR>:set ft=json<CR>
vnoremap <leader>j :!python -m json.tool<CR>:set ft=json<CR>



" FILETYPE-SPECIFIC STUFF ====================================================
" PICO-8: Use lua syntax highlighting, use 2-space tabs, fold non-lua sections
let g:syntastic_ignore_files = ['\.p8$']
au BufRead,BufNewFile *.p8 call InitPico8()
function! InitPico8()
    setlocal ft=lua ts=2 sw=2 sts=2
    set foldmethod=manual
    normal zE
    call feedkeys("/__lua__/\<CR>zfgg", 'x')
    call feedkeys("/__gfx__/\<CR>zfG", 'x')
    normal gg
endfunction

" PHP
au BufRead,BufNewFile *.php setlocal formatoptions-=w

" CSS: Make C-n autocomplete more useful
autocmd FileType css,scss setlocal iskeyword=@,48-57,_,-,?,!,192-255

" Go: Use tabs, displayed as 8 spaces
au BufNewFile,BufRead *.go setlocal noet tabstop=8 shiftwidth=8 softtabstop=8

" JavaScript: use 2 spaces for tabs
set tabstop=8 expandtab shiftwidth=2 softtabstop=2

" Markdown: Use 4-space tabs
au BufNewFile,BufRead *.md setlocal expandtab ts=4 sw=4 softtabstop=4






" PLUGIN CONFIGURATION =======================================================
" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

" ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_custom_ignore =
    \ '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" ctrlsf.vim
" Open CtrlSFPrompt with Ctrl + S
nmap <C-S> <Plug>CtrlSFPrompt
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_winsize = '90%'
let g:ctrlsf_ignore_dir = ["build"]

" ALE
let g:ale_open_list = 0
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
let g:ale_linters = {'go': [ 'go vet', 'golint', 'gometalinter', 'go build', 'gosimple', 'staticcheck']}

" vim-go
let g:go_metalinter_autosave = 0
let g:go_fmt_fail_silently = 0

" vim-markdown-preview
let vim_markdown_preview_toggle = 2 " Generate markdown preview on buffer write
let vim_markdown_preview_github = 1
let vim_markdown_preview_hotkey='<leader>m'
"nnoremap <leader>m :call Vim_Markdown_Preview()<CR>



" STATUS LINE ==================================================
set statusline=\ 
set laststatus=2
set statusline=%{LinterStatus()}

" Add ruler and git status (via vim-fugitive) to right side of statusline
set statusline+=%=
set statusline+=%{fugitive#statusline()}
set statusline+=\ \ %=%l\:%c\ \ \ 
