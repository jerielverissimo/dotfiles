set exrc
set guicursor=
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set wildmenu "tab completion
set wildmode=longest:full,full " First tab brings up options, second tab cycles
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set omnifunc=syntaxcomplete#Complete      " enable omnicomplete <C-x><C-o>
set colorcolumn=80
set signcolumn=yes
set mouse=a
set splitbelow splitright                 " put new split windows below and right

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (deault is 4000 ms = 4s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" copy to clipboard
set clipboard+=unnamedplus


" Fold
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

let g:dart_format_on_save = 1

