" -------------
" Load Pathogen
" -------------
"set nocp
"execute pathogen#infect()

" ----------------------------
" Load Plug and define plugins
" ----------------------------
call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'dracula/vim.git'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'sjl/gundo.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'nvie/vim-flake8', { 'for': 'python'}
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'evidens/vim-twig', { 'for': 'twig' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

call plug#end()

" -----------------
" Syntax and indent
" -----------------
syntax on       " turn on syntax highlighting
set showmatch   " show matching braces when text indicator is over them

filetype plugin indent on   " enable file type detection

" MAYBE highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

set autoindent


" --------------------
" Basic editing config
" --------------------
set relativenumber  " relative line numbering
set incsearch       " search while string is being typed
set hls             " highlight search
set listchars=tab:>>,nbsp:~     " set list to see tabs and non-breakable spaces
set linebreak
set ruler           " show current position in file
set scrolloff=5     " show lines above and below cursor
set noshowmode      " hide mode
set laststatus=2
set showcmd         " show current command
set backspace=indent,eol,start  " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow 0 inserts
set lazyredraw      " skip redrawing screen in some cases
set autochdir       " automatically cd to dir of last opened file
set hidden          " allow auto-hiding of edited buffers
set history=8192    " more history
set clipboard=unnamedplus       " set clipboard to ctrl-v instead of mousewheel

" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" smart case-sensitive search
set ignorecase
set smartcase

" tab completion for files/buffers
set wildmode=longest,list
set wildmenu
set mouse+=a        " enable mouse mode (scrolling, selection, etc)


" -------------------
" Misc configurations
" -------------------

" propper splitting
set splitbelow
set splitright

" map Ctrl hjkl for fast split movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" bind F3 to search highlighting
nnoremap <F3> :set hlsearch!<CR>

" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

" map Ctrl ; to replace regular Ctrl J (jumping)
nnoremap <C-;> <C-J>

" increase scroll speed (Ctrl E, Ctrl Y)
noremap <C-E> 8<C-E>
noremap <C-Y> 8<C-Y>


" --------------------
" Plugin configuration
" --------------------

" tagbar
nnoremap <Leader>t :TagbarToggle<CR>

" gundo
nnoremap <Leader>u :GundoToggle<CR>

" ctrlp
nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " Ignore files in gitignore
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" easymotion
map  <Space> <Plug>(easymotion-prefix)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

source ~/.vim/vimrc-local
