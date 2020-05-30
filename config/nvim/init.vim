call plug#begin()

" General Plugins {
  " Autocomplete
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'machakann/vim-sandwich'                           " make sandwiches
  Plug 'jiangmiao/auto-pairs'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }

  " Startup
  Plug 'mhinz/vim-startify' 
  
  " Navigation 
  Plug 'scrooloose/nerdtree'
  Plug 'terryma/vim-multiple-cursors'
  
  " Theme Plugins 
  Plug 'sainnhe/gruvbox-material'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 

  " Fuzzy finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'   " fuzzy search integration
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/vim-grep'

  " Window
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/goyo.vim'              " zen mode

  " Syntaxe check and linting 
  Plug 'w0rp/ale'
  Plug 'neomake/neomake'
  Plug 'sheerun/vim-polyglot'
  "Plug 'nathanaelkane/vim-indent-guides'
  Plug 'Yggdroot/indentLine'
  Plug 'vim-scripts/TagHighlight'

  " Easily comment - <Leader>cc
  Plug 'scrooloose/nerdcommenter'

  " Git support
  Plug 'tpope/vim-fugitive'
  "Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/gv.vim'
" }

  " Languages 

  Plug 'neovimhaskell/haskell-vim' 
  Plug 'rust-lang/rust.vim'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'mattn/emmet-vim'
  Plug 'vim-latex/vim-latex'
  Plug 'keith/swift.vim'
  Plug 'arrufat/vala.vim'


" RubyPlugins {
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rvm'
  Plug 'ngmy/vim-rubocop'
  Plug 'rainerborene/vim-reek'
  Plug 'tpope/vim-cucumber'
" }

" Notes 
  Plug 'vimwiki/vimwiki'
  Plug 'tbabej/taskwiki'

" SnippetsPlugins {
  Plug 'kristijanhusak/vim-carbon-now-sh'  " lit code screenshots
" }

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
  set emoji  " enable emojis

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
    set grepprg=rg\ --vimgrep
    let g:ctrlp_user_command = 'rg %s --files --glob ""'
    let g:ctrlp_use_caching = 0
  endif
" }

" Use ripgrep for fzf
let $FZF_DEFAULT_COMMAND='rg %s --files --glob ""'

" Configure FZF to use a floating window configuration
let $FZF_DEFAULT_OPTS = '--layout=reverse' " top to bottom
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine'],
            \ 'bg+':     ['bg', 'Normal'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'CursorLine'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" ======================== Filetype-Specific Configurations ============================= "

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown set spell
autocmd FileType markdown map <silent> <leader>m :call TerminalPreviewMarkdown()<CR>

" ================== Custom Functions ===================== "

" markdown files preview inside (you need to install mdv)
function! TerminalPreviewMarkdown()
    vsp | terminal ! mdv -t 845.69 %
endfu

" Theme Options {

  let g:gruvbox_material_background = 'soft'

  set termguicolors
  set guifont=FiraMono\ Nerd\ Font\ Regular\ 16
  syntax enable
  set t_Co=256
  set fillchars+=vert:\|
  colorscheme gruvbox-material
  set background=dark

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
   "map gn :bn<cr>
   "map gp :bp<cr>
   "map gd :bd<cr>
  " }

  " Open lazygit
  nnoremap <silent> <Leader>' :call ToggleLazyGit()<CR>
  " Open lazydocker
  nnoremap <silent> <Leader>d :call ToggleLazyDocker()<CR>
  " Open scratch term
  nnoremap <silent> <Leader>b :call ToggleScratchTerm()<CR>

  " Windows {
  
    " Close nerdtree after a file is selected
    let NERDTreeQuitOnOpen = 1
    let NERDTreeIgnore = ['\.o$[[file]]']

    function! IsNERDTreeOpen()
        return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
    endfunction

    function! ToggleFindNerd()
        if IsNERDTreeOpen()
            exec ':NERDTreeToggle'
        else
            exec ':NERDTreeFind'
        endif
    endfunction

    " If nerd tree is closed, find current file, if open, close it
    nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
    nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>
    nnoremap <silent> <leader>ff :call Fzf_dev()<CR>

    " Enter on zen mode
    nmap <leader>g :Goyo<CR>

    " for project wide search
    map <leader>/ :Ag<CR>
  " }
  " GIT WINDOW
  let g:gitgutter_preview_win_floating = 1
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

  let g:ale_rust_rls_toolchain = 'nightly'
  let g:ale_completion_enabled = 1
  let g:ale_rust_cargo_use_check = 1
  let g:ale_linters = {
            \ 'javascript': ['eslint'],
            \ 'python': ['pyls'],
            \ 'php': ['langserver'],
            \ 'rust': ['rls'],
            \ 'elixir': ['elixir-ls'],
            \ 'c': ['clangd']
            \}

  set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
" }

" Neomake {
  let g:neomake_warning_sign = {'text': '?'}
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

"}

" Creates a floating window with a most recent buffer to be used
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    autocmd BufWipeout <buffer> call CleanupBuffer(s:buf)
    tnoremap <buffer> <silent> <Esc> <C-\><C-n><CR>:call DeleteUnlistedBuffers()<CR>
endfunction


" Files + devicons + floating fzf
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'
  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})

endfunction

"##############################################################################
" Terminal Handling
"##############################################################################

" Set login shell for :terminal command so aliases work
set shell=/bin/bash

" When term starts, auto go into insert mode
autocmd TermOpen * startinsert

" Turn off line numbers etc
autocmd TermOpen * setlocal listchars= nonumber norelativenumber

function! ToggleTerm(cmd)
    if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
    else
        call DeleteUnlistedBuffers()
    endif
endfunction

function! ToggleScratchTerm()
    call ToggleTerm('bash')
endfunction

function! ToggleLazyGit()
    call ToggleTerm('lazygit')
endfunction

function! ToggleLazyDocker()
    call ToggleTerm('lazydocker')
endfunction

function! OnTermExit(job_id, code, event) dict
    if a:code == 0
        call DeleteUnlistedBuffers()
    endif
endfunction

function! DeleteUnlistedBuffers()
    for n in nvim_list_bufs()
        if ! buflisted(n)
            let name = bufname(n)
            if name == '[Scratch]' ||
              \ matchend(name, ":bash") ||
              \ matchend(name, ":lazygit") ||
              \ matchend(name, ":lazydocker")
                call CleanupBuffer(n)
            endif
        endif
    endfor
endfunction

function! CleanupBuffer(buf)
    if bufexists(a:buf)
        silent execute 'bwipeout! '.a:buf
    endif
endfunction
