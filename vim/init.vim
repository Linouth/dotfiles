set laststatus=2
set splitbelow
set splitright
set relativenumber
set clipboard=unnamedplus

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set nolazyredraw

" set exrc " Source .vimrc file from cwd
" set secure


nnoremap <F3> :set hlsearch!<CR>

" Map Ctrl hjkl for fast split movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map Ctrl ; to replace regular Ctrl J (jumping)
nnoremap <M-J> <C-J>

" Increase scroll speed (Ctrl E, Ctrl Y)
noremap <C-E> 8<C-E>
noremap <C-Y> 8<C-Y>


" Load Pathogen
set nocp
execute pathogen#infect()
syntax on
filetype plugin indent on

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " Ignore files in gitignore
