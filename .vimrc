set tabstop=4     " tab spacing (setting below is just to unify it)
set softtabstop=4 " unify
set expandtab     " NO tabs please!
syntax on
filetype indent plugin on
set undofile "undo peristance

set nomodeline "security https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'  " file list
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'tpope/vim-surround'
Plug 'nvie/vim-flake8'

call plug#end()

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:gutentags_project_root = ['.svn']
let g:gutentags_ctags_exclude = ['*.json']

"==misc ui
set backspace=indent,eol,start "allow backspace to delete indent, lines
set wildmenu
set path+=**

"== clear line numbers on :Clear
command Clear set nonumber norelativenumber
set number relativenumber

"== hotkeys
"==statusline
highlight StatusLine ctermbg=Black ctermfg=Blue gui=NONE cterm=NONE term=NONE
set statusline=%#StatusLine#\ %m%r\ %<%f\ %h%=%-14.(%l,%c%V%)\ %P
set ls=2 "show statusline always
autocmd InsertEnter * highlight StatusLine ctermbg=Blue ctermfg=Black
autocmd InsertLeave * highlight StatusLine ctermbg=Black ctermfg=Blue

"==visibility of naughty characters and special keywords
set listchars=tab:»·,trail:␣,nbsp:˷
set list "show bad chars as the above substitutes

highlight InvisibleSpaces ctermbg=Black ctermfg=Blue
highlight FlagSpecial ctermbg=Blue ctermfg=White
call matchadd('InvisibleSpaces', '\s\+$', -10)
call matchadd('FlagSpecial', 'TODO', 1)

"== run mypy on :make pygrep on :grep Flake8 on :Flake
set makeprg=mypy\ --strict\ --ignore-missing-imports\ .
set errorformat=%f:%l:%m
set grepprg=grep\ -rIn\ --exclude-dir=venv\ --include='*.py'\ $*
command Flake :call flake8#Flake8()

nnoremap <C-f> :NERDTreeToggle<CR>
"toggle nerdtree on ctrl+f
nnoremap <C-n> :cnext<CR>
"next item in quickfix on ctrl+n

"==autoclose brackets
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
