syntax enable
colorscheme dark-ruby
set colorcolumn=80 "adds a bar at 80 chars wide

set cursorcolumn " displays a column where the carat is
set cursorline " displays a line under the current row the caret is on

set tabstop=2
set shiftwidth=2
set expandtab
set number "displays line numbers
set wildmode=longest,list
set wildmenu "enable bash <tab><tab> to list dir
set incsearch
set hlsearch " highlight all search matches
set autoindent
filetype plugin indent on
set scrolloff=2 " scroll 2 lines before edge of screen
set laststatus=2 " always show status bar
"set noai
" set ruler " is default
" set laststatus=1 " is default
"

"custom colors
set t_Co=256 " set 256 colours
set background=dark
hi CursorLine ctermbg=234 term=none cterm=none
hi clear CursorColumn
hi CursorColumn ctermbg=234
hi ColorColumn ctermbg=233
hi LineNr ctermfg=darkgrey ctermbg=233
" hi Visual term=bold cterm=italic

if has("autocmd")
  hi ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
  autocmd! bufwritepost vimrc source ~/.vimrc
  autocmd WinLeave * set nocursorline nocursorcolumn
  autocmd WinEnter * set cursorline cursorcolumn
endif

set backupdir=~/.vim/tmp  "Store backups in same dir
set directory=~/.vim/tmp  "Store swps in same dir

" if has("folding")
"   set foldmethod=indent
"   set foldlevel=99
" endif

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"mappings
map <C-t> :NERDTreeToggle <cr>
map <S-k> :! <cr>

map <leader>def :Ack "def " <C-r>%<cr>
map <leader>desc :Ack "describe " <C-r>%<cr>

map <leader>ss :setlocal spell!<cr> :echo "SpellChecker ="&spell<cr>
map <leader>pp :setlocal paste!<cr> :echo "Paste Mode ="&paste<cr>
map <leader>nn :set number!<cr>

map <F3> :call SetLineNumbers()<CR> :! clear; echo "Testing:" <C-r>% "Line:" <C-r>l; bundle exec rspec <C-r>% -l <C-r>l<cr>
map <F6> :set wrap!<cr> :echo "Wrap Lines ="&wrap<cr>
map <F8> :! clear; echo "Testing file:" <C-r>%;bundle exec rspec <C-r>%<cr>

" toggle mouse mode
map <F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>

map <leader>b :call SetLineNumbers()<CR> :! clear; echo "git blame "<C-r>%; git blame <C-r>% -L <C-r>x,<C-r>c<cr>
map <leader>d :! clear; echo "git diff "<C-r>%;git diff <C-r>% <cr>

"Convert CacmelCase string into snake_case
vmap <F9> :s#\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g <CR>

"Convert snake_case string into CamelCase
vmap <F10> :s#\(\%(\<\l\+\)\%(_\)\@=\)\\|_\(\l\)#\u\1\2#g <CR>

map <Tab> ==

function ShowMouseMode()
  if (&mouse == 'a')
    echo "MouseMode On"
  else
    echo "MouseMode Off"
  endif
endfunction

function SetLineNumbers()
  let @l = line('.')
  let @x = -3 + line('.')
  let @c = 3 + line('.')
endfunction
