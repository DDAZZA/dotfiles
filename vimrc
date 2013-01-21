let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:ackprg="ack -H --nocolor --nogroup --column"

syntax enable

"custom colors
set t_Co=256 " set 256 colours
colorscheme wombat256mod

set colorcolumn=80 "adds a bar at 80 chars wide
hi ColorColumn ctermbg=black

set colorcolumn=80 "adds a bar at 80 chars


set tabstop=2
set shiftwidth=2
set expandtab
set number "displays line numbers
set wildmode=longest,list
set wildmenu "enable bash <tab><tab> to list dir
set incsearch "show match when typing
set ignorecase
set hlsearch " highlight all search matches
set autoindent
filetype plugin indent on
set scrolloff=2 " scroll 2 lines before edge of screen
set laststatus=2 " always show status bar
set wrap! "don't wrap text

if has("autocmd")
  hi ExtraWhitespace ctermbg=red
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  set cursorcolumn " displays a column where the carat is
  set cursorline " displays a line under the current row the caret is on
  autocmd WinLeave * set nocursorline nocursorcolumn
  autocmd WinEnter * set cursorline cursorcolumn

  autocmd! BufWritePost .vimrc source ~/.vimrc " reload vim file when its saved
  autocmd BufNewFile,BufRead *.ui set filetype=ruby
  autocmd BufNewFile,BufRead  Gemfile set filetype=ruby
endif

set backupdir=~/.vim/tmp  "Store backups in same dir
set directory=~/.vim/tmp  "Store swps in same dir

if has("folding")
  set foldmethod=indent   "fold based on indent
  set foldnestmax=3       "deepest fold is 3 levels
  set nofoldenable        "dont fold by default
endif

"mappings
nmap , \

map <Tab> ==
imap <Tab> <C-p>
imap § <ESC>
nmap <S-k> :!<CR>
nmap <leader>pp :normal orequire 'pry'; binding.pry<ESC>
nmap <leader>b :call GitBlame()<CR>
nmap <leader>def :Ack "def " <C-r>%<CR>
nmap <leader>desc :Ack "describe " <C-r>%<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>nn :set number!<CR>
nmap <leader>p :setlocal paste!<CR>:echo "Paste Mode ="&paste<CR>
nmap <leader>ss :setlocal spell!<CR>:echo "SpellChecker ="&spell<CR>
nmap <leader>tf :call TestFile()<CR>
nmap <leader>tt :call TestLine()<CR>

" nmap <F6> :set wrap!<CR> :echo "Wrap Lines ="&wrap<CR>
nmap <F7> :! ruby app.rb<CR>
map <F12> :call ToggleMouseMode()<CR>

command! SaveSession :call SaveSession()
function! SaveSession()
  mksession! ~/.vim/vim_session
endfunction

command! LoadSession :call LoadSession()
function! LoadSession()
  source ~/.vim/vim_session
endfunction

function! TestFile()
  let l:command = "bundle exec rspec " . @%
  call ExecCmd(l:command)
endfunction

function! TestLine()
  let l:command = "bundle exec rspec " . @% . " -l " . line(".") . " -f documentation"
  call ExecCmd(l:command)
endfunction

function! GitBlame()
  let l:p = -3 + line('.')
  let l:n = 3 + line('.')
  let l:command = "git blame " . @% . " -w -L " . l:p . "," . l:n
  call ExecCmd(l:command)
endfunction

function! ExecCmd(command)
  execute "!clear && echo " . a:command . " && echo && " . a:command
endfunction

command! -nargs=* Taback :call Taback(<q-args>)
function! Taback(params)
  tabnew
  call Ack(a:params)
endfunction

function! ToggleMouseMode()
  let &mouse=(&mouse == "a"?"":"a")
  if (&mouse == 'a')
    echo "MouseMode On"
  else
    echo "MouseMode Off"
  endif
endfunction
