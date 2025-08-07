" [[ Keymaps ]]

" Swap <Esc> and <C-c>
noremap <Esc> <C-c>
noremap <C-c> <Esc>
noremap! <Esc> <C-c>
noremap! <C-c> <Esc>

" Set leader
let mapleader=' '

" Tab management
nnoremap <Leader>tc <CMD>tabclose<CR>
nnoremap <Leader>tn <CMD>tabnew<CR>
nnoremap <Leader>to <CMD>tabonly<CR>
nnoremap <Leader>t> <CMD>+tabmove<CR>
nnoremap <Leader>t< <CMD>-tabmove<CR>

" Paste the most recent yank
noremap <Leader>p "0p
noremap <Leader>P "0P

" Buffer navigation
nnoremap <Leader>sb :ls<CR>:b<Space>

" Yank to end of line
nnoremap Y y$

" [[ Options ]]

" Display line numbers
set number
set relativenumber

" Disable line wrapping
set nowrap

" Search settings
set nohlsearch
set ignorecase
set smartcase

" Indentation settings
set tabstop=4
set shiftwidth=0 " follow tabstop
set softtabstop=-1 " follow shiftwidth
set list
set listchars=tab:\ \ ,trail:·,nbsp:␣

" Folding settings
set nofoldenable
set foldmethod=indent
set foldlevel=99
set foldtext='""'

" Automatically focus new splits
set splitright
set splitbelow

" Keep cursor centered
set scrolloff=12
set sidescroll=0

" Use system clipboard
set clipboard=unnamedplus

" Enable mouse usage
set mouse=a

" Increase mapping timeout
set timeoutlen=2000

" Disable error sounds
set noerrorbells
set novisualbell

" Save undo history
if has('persistent_undo')
  if !isdirectory($HOME . '/.vim/undo')
    call mkdir($HOME . '/.vim/undo', 'p')
  endif
  set undodir=$HOME/.vim/undo
  set undofile
endif

" Set terminal colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Disable SQL mappings
let g:omni_sql_no_default_maps = 1

" [[ Plugins ]]

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Load plugins
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
call plug#end()

" Disable sneak highlighting
highlight! link Sneak None
highlight! link SneakCurrent None
autocmd User SneakLeave highlight clear Sneak | highlight clear SneakCurrent

" Undotree options
nnoremap <Leader>u <CMD>UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 40
let g:undotree_DiffpanelHeight = 12

" Set colorscheme
colorscheme onehalfdark
