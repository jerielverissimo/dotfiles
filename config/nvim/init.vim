call plug#begin()

" General Plugins {
  " Autocomplete
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} 
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
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

  " Fuzzy finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'ctrlpvim/ctrlp.vim'

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
  Plug 'junegunn/gv.vim'
" }

  " Languages 

  Plug 'neovimhaskell/haskell-vim' 
  Plug 'rust-lang/rust.vim'
  Plug 'dart-lang/dart-vim-plugin'

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
  "set scrolloff=5   " Keep some distance to the bottom

  " Fold
  set foldmethod=indent   
  set foldnestmax=10
  set nofoldenable
  set foldlevel=2

" }

" CtrlP using ripgrep {
  if executable('rg')
    set grepprg=rg\ 
    let g:ctrlp_user_command = 'rg %s --files --glob ""'
    let g:ctrlp_use_caching = 0
  endif
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
  let g:airline#extensions#ale#enabled = 1
  let g:airline_powerline_fonts = 1
" }

" Map Options {

  " Select all
  map <C-a> <esc>ggVG<CR>

 " Buffers {
   map gn :bn<cr>
   map gp :bp<cr>
   map gd :bd<cr>
  " }
    
  " Windows {
    map <leader>f :NERDTreeFind<CR>
    let NERDTreeQuitOnOpen = 1 " Close nerdtree after a file is selected
  " }
" }


" ALE {
  let g:ale_lint_on_text_changed = 1 "dont lint on text change
  let g:ale_lint_on_save = 1 "lint on save
  let g:ale_sign_warning = ''
  let g:ale_sign_error = ''
  let g:ale_echo_msg_format = '[%severity%]: %s [%linter%]'
  let g:ale_statusline_format = ['E:%s', 'W:%s', 'OK']
  highlight ALEErrorSign ctermbg=NONE ctermfg=red
  highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
  let g:ale_lint_delay = 800
" }

" Coc configuration { 

  " Some servers have issues with backup files
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>ff  <Plug>(coc-format-selected)
  nmap <leader>ff  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}
