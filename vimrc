let g:ackprg="ack-grep -H --nocolor --nogroup --column"
syntax enable
colorscheme dark-ruby
set colorcolumn=80
set background=dark
set tabstop=2
set shiftwidth=2
set expandtab
set number
set wildmode=longest,list
set wildmenu
set incsearch
set hlsearch
"set smartindent
set autoindent
filetype plugin indent on
set scrolloff=2
set t_Co=256
set ls=2
"set noai
" set ruler " is default
" set laststatus=1 " is default
hi LineNr ctermfg=darkgrey
hi ColorColumn ctermbg=black

if has("autocmd")
  hi ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
  autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc
endif

set backupdir=~/.vim/tmp  "Store backups in same dir
set directory=~/.vim/tmp  "Store swps in same dir

if has("folding")
  set foldmethod=indent
  set foldlevel=99
endif

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
map <F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>

map <leader>b :call SetLineNumbers()<CR> :! clear; echo "git blame "<C-r>%; git blame <C-r>% -L <C-r>x,<C-r>c<cr>
map <leader>d :! clear; echo "git diff "<C-r>%;git diff <C-r>% <cr>

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
