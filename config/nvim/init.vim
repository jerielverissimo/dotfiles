call plug#begin()

" General Plugins {
  " Autocomplete
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} 
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }

  " Navigation 
  Plug 'scrooloose/nerdtree'
  
  " Theme Plugins 
  Plug 'sainnhe/gruvbox-material'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 

  " Window
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Syntaxe check and linting 
  Plug 'w0rp/ale'
  Plug 'neomake/neomake'

  " Easily comment - <Leader>cc
  Plug 'scrooloose/nerdcommenter'

  " Git support
  Plug 'tpope/vim-fugitive'
  Plug 'Xuyuanp/nerdtree-git-plugin'
" }

  " Languages 

  Plug 'neovimhaskell/haskell-vim' 
  Plug 'rust-lang/rust.vim'

call plug#end()

" General Options {
  let mapleader=" "
  set history=1000
  set encoding=utf-8
  set mouse=a " Enable mouse support
  set number 
  set relativenumber
  set autoread
  set hidden " Allows you to switch buffers without saving current

  filetype plugin indent on

  " Redraw screen and clear highlighting
  nnoremap <Leader>r :nohl<CR><C-L>

  " copy to clipboard
  set clipboard+=unnamedplus

  " Buffers
  map gn :bn<cr>
  map gp :bp<cr>
  map gd :bd<cr>

  " Tabs
  set wildmenu "tab completion
  set wildmode=longest:full,full " First tab brings up options, second tab cycles
  set expandtab
  set smarttab
  set tabstop=2

  " Better searching
  set incsearch " Search as you type
  set ignorecase
  set smartcase
  set wrapscan "wraps around end of file

  " Show matching bracket
  set showmatch " Show matching of: () [] {}
  set matchtime=2
  set shiftwidth=2 " Even if there are tabs, preview as 2 spaces

  set smartindent " Be smart about indentation
  set scrolloff=5   " Keep some distance to the bottom

  " Fold
  set foldmethod=indent   
  set foldnestmax=10
  set nofoldenable
  set foldlevel=2

  " Select all
  map <C-a> <esc>ggVG<CR>

" }

" Windows {
  map <leader>f :NERDTreeToggle<CR>

  " NERDTree
  let NERDTreeQuitOnOpen = 1 " Close nerdtree after a file is selected
" }


" Theme Options {
  set termguicolors
  syntax enable
  set t_Co=256
  set fillchars+=vert:\|
  colorscheme gruvbox-material-soft

  " Airline theme
  let g:airline_theme = 'gruvbox_material'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
" }

