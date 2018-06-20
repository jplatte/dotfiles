" show line numbers
set number

" work around stupid bug
set guicursor=

" tab configuration
set shiftwidth=4
set tabstop=4
set expandtab

" substitute all matches on a line by default (adding g at the end then
" reverts it back to only substitute the first match)
set gdefault

" show substitution effects as you are typing
set inccommand=nosplit

" disable standard mode display in cmdline, bc. lightline does it better
set noshowmode

" enable full color support
set termguicolors

" save cursor position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" set leader key for easymotion
let mapleader = ","

" make patterns case-insensitive if they don't contain uppercase letters
set ignorecase
set smartcase

" always use "very magic" regex syntax
nnoremap / /\v
nnoremap ? ?\v

" use Ctrl+hjkl for split navigation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" whitespace stuff
set list
set listchars=tab:›\  " this comment needs to be here to stop automatic trailing whitespace removal

" highlight cursor line
set cursorline

" mark trailing whitespace red
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces#Highlighting_with_the_match_command
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/

" better editor splits
set splitright
set splitbelow

" dein (Plugin manager)
if &compatible
  set nocompatible
endif
filetype off
" append to runtime path
set rtp+=/usr/share/vim/vimfiles
" initialize dein, plugins are installed to this directory
call dein#begin(expand('~/.cache/dein'))
" add packages here
call dein#add(
    \ 'tpope/vim-fugitive',
    \ {
        \ 'on_cmd': [
            \ 'Gblame',
            \ 'Gbrowse',
            \ 'Gcommit',
            \ 'Gdelete',
            \ 'Gdiff',
            \ 'Gedit',
            \ 'Ggrep',
            \ 'Git',
            \ 'Glog',
            \ 'Gmove',
            \ 'Gread',
            \ 'Gsplit',
            \ 'Gstatus',
            \ 'Gtabedit',
            \ 'Gvsplit',
            \ 'Gwrite',
        \ ]
    \ }
\ )
call dein#add('airblade/vim-gitgutter')

call dein#add('morhetz/gruvbox')
call dein#add('luochen1990/rainbow')

call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('easymotion/vim-easymotion')

call dein#add('mhinz/vim-startify')

call dein#add('scrooloose/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

call dein#add('itchyny/lightline.vim')

call dein#add('plasticboy/vim-markdown')
call dein#add('cespare/vim-toml')

call dein#add('editorconfig/editorconfig-vim')
call dein#add('rhysd/vim-clang-format')
call dein#add('rust-lang/rust.vim')
call dein#add('mzlogin/vim-markdown-toc')
" exit dein
call dein#end()
" auto-install missing packages on startup
if dein#check_install()
  call dein#install()
endif
filetype plugin on

" gruvbox configuration
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" activate rainbow parentheses
let g:rainbow_active = 1

" don't apply editorconfig to git buffers
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" auto-enable clang-format for C and C++ (?)
autocmd FileType c ClangFormatAutoEnable
