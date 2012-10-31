let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:ackprg="ack -H --nocolor --nogroup --column"

syntax enable
set t_Co=256 " set 256 colours
colorscheme wombat256mod

set colorcolumn=80 "adds a bar at 80 chars wide

set cursorcolumn " displays a column where the carat is
set cursorline " displays a line under the current row the caret is on

set tabstop=2
set shiftwidth=2
set expandtab
set number "displays line numbers
set wildmode=list:longest,full
set wildmenu "enable bash <tab><tab> to list dir

set incsearch "show match when typing
set ignorecase
set smartcase
set hlsearch " highlight all search matches
set autoindent
filetype plugin indent on
set scrolloff=2 " scroll 2 lines before edge of screen
set laststatus=2 " always show status bar
set wrap! "don't wrap text

"custom colors
hi ColorColumn ctermbg=black

if has("autocmd")
  hi ExtraWhitespace ctermbg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  " line is longer than 80 chars
  " autocmd InsertLeave * match ExtraWhitespace /\%>80v.\+/
  autocmd BufWinLeave * call clearmatches()
  autocmd WinLeave * set nocursorline nocursorcolumn
  autocmd WinEnter * set cursorline cursorcolumn
  autocmd! bufwritepost .vimrc source ~/.vimrc " reload vim file when its saved
  autocmd BufNewFile,BufRead *.ui set filetype=ruby
endif

" set undodir=~/.vim/tmp
" set undofile
set backupdir=~/.vim/tmp  "Store backups in same dir
set directory=~/.vim/tmp  "Store swps in same dir

if has("folding")
  set foldmethod=indent   "fold based on indent
  set foldnestmax=3       "deepest fold is 3 levels
  set nofoldenable        "dont fold by default
endif


"mappings
nmap <C-t> :NERDTreeToggle <CR>
nmap <S-k> :!<CR>

nmap <leader>def :Ack "def " <C-r>%<CR>
nmap <leader>desc :Ack "describe " <C-r>%<CR>

nmap <leader>ss :setlocal spell!<CR> :echo "SpellChecker ="&spell<CR>
nmap <leader>pp :setlocal paste!<CR> :echo "Paste Mode ="&paste<CR>
nmap <leader>nn :set number!<CR>
nnoremap Y y$

map <F1> <ESC>
map <F2> :normal orequire 'pry'; binding.pry<ESC>
map § <ESC>
nmap <F3> :call SetLineNumbers()<CR> :! clear; echo "Testing:" <C-r>% "Line:" <C-r>l; bundle exec rspec <C-r>% -l <C-r>l<CR>
nmap <F5> :! !bundle<CR>
" nmap <F6> :set wrap!<CR> :echo "Wrap Lines ="&wrap<CR>
nmap <F7> :! ruby app.rb<CR>
nmap <F8> :! clear; echo "Testing file:" <C-r>%;bundle exec rspec <C-r>%<CR>

" toggle mouse mode
map <F12> :call ShowMouseMode()<CR>

map <leader>b :call SetLineNumbers()<CR> :! clear; echo "git blame "<C-r>%; git blame <C-r>% -L <C-r>x,<C-r>c<CR>
map <leader>d :! clear; echo "git diff "<C-r>%;git diff <C-r>% <CR>

"Convert CacmelCase string into snake_case
vmap <F9> :s#\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g <CR>

"Convert snake_case string into CamelCase
vmap <F10> :s#\(\%(\<\l\+\)\%(_\)\@=\)\\|_\(\l\)#\u\1\2#g <CR>

" Restart a rails server
map <silent> <F6> :! pkill -2 -f 'script\/rails s' <cr> :echo 'Restarting rails server...'<cr>

map <Tab> ==


command! -nargs=* Taback :call Taback(<q-args>)

function! Taback(params)
  echo 'hello'
  echo params
  " tabnew
  " Ack(params)
endfunction

function! ShowMouseMode()
  let &mouse=(&mouse == "a"?"":"a")
  if (&mouse == 'a')
    echo "MouseMode On"
  else
    echo "MouseMode Off"
  endif
endfunction

function! SetLineNumbers()
  let @l = line('.')
  let @x = -3 + line('.')
  let @c = 3 + line('.')
endfunction
