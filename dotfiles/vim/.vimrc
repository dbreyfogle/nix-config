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

" Open explorer
nnoremap - :Ex<CR>

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

" Enable mouse usage
set mouse=a

" Increase mapping timeout
set timeoutlen=2000

" Enable syntax highlighting
syntax enable

" Disable error sounds
set noerrorbells
set novisualbell
