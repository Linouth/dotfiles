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
Plug 'arcticicestudio/nord-vim'
Plug 'flazz/vim-colorschemes'

Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'evidens/vim-twig', { 'for': 'twig' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'lervag/vimtex', { 'for': 'latex' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Plug 'KeitaNakamura/highlighter.nvim'

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
set nu
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

" Deoplete
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#clang#libclang_path = '/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

" Use smartcase.
call deoplete#custom#option('smart_case', v:true)

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <C-g>; undo last insert
inoremap <expr><C-g>     deoplete#undo_completion()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<Tab>"

" Jedi-VIM
let g:jedi#completions_enabled = 0

" Highlighter
let g:highligher#auto_update = 2
let g:highlighter#project_root_signs = ['.git']

" Ale linter
" let g:ale_c_parse_makefile = 1
let g:ale_c_parse_compile_commands = 1
" let g:ale_c_clang_options = '-I/home/marten/src/ESP32/btrecv/ /home/marten/src/ESP32/esp-idf/components/**/include/**'



source ~/.vim/vimrc-local

