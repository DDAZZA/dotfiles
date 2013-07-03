" apparently speeds up vim viewing using ruby code
let g:ruby_path = system('echo $HOME/.rbenv/shims')

syntax enable

set t_Co=256 " set 256 colours
colorscheme wombat256mod
set colorcolumn=80 "adds a bar at 80 chars wide
hi ColorColumn ctermbg=black

set tabstop=2
set shiftwidth=2
set expandtab
set number "displays line numbers
set wildmode=longest,list
set wildmenu "enable bash <tab><tab> to list dir
set incsearch "show match when typing
" set ignorecase
set hlsearch " highlight all search matches
set autoindent
filetype plugin indent on
set scrolloff=2 " scroll 2 lines before edge of screen
set wrap! "don't wrap text
set laststatus=2 "always show status bar
set timeoutlen=500

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

"map leader to , and \
map , \

"mappings
imap § <ESC>
nmap <S-k> :!<CR>

nmap <leader>pp :normal orequire 'pry'; binding.pry<ESC>==
nmap <leader>def :Ack "def \\|private" <C-r>%<CR>
nmap <leader>desc :Ack "describe " <C-r>%<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>nn :set number!<CR>
nmap <leader>p :setlocal paste!<CR>:echo "Paste Mode ="&paste<CR>
nmap <leader>ss :setlocal spell!<CR>:echo "SpellChecker ="&spell<CR>

nmap <leader>gb :call GitBlame()<CR>

" Show git status
nmap <leader>gs :call ExecCmd("git status")<CR>

" Run test on the whole file
nmap <leader>tf :call RunTest(@%)<CR>

" Run tests on the current line
nmap <leader>tt :call TestLine()<CR>

" Run the last test again
nmap <leader>tl :call ExecCmd(w:command)<CR>

nmap <leader>lc :call LatexCompile()<CR>

" nmap <F6> :set wrap!<CR> :echo "Wrap Lines ="&wrap<CR>
nmap <F7> :! ruby app.rb<CR>
map <F12> :call ToggleMouseMode()<CR>

" Save the current open windows
command! SaveSession mksession! ~/.vim/vim_session

" Load the last saved session
command! LoadSession source ~/.vim/vim_session

command! LatexCompile :call ExecCmd("pdflatex " . @%)<CR>

function! TestLine()
  let l:command =  "-f documentation -l " . line(".") . ' ' . @%
  call RunTest(l:command)
endfunction

function! RunTest(command)
  let w:command = (system("pgrep zeus") != '') ? "zeus " : "bundle exec "
  let w:command .= 'rspec --profile ' . a:command
  call ExecCmd(w:command)
endfunction

function! GitBlame()
  let l:p = -3 + line('.')
  let l:n = 3 + line('.')
  let l:command = "git blame " . @% . " -w -L " . l:p . "," . l:n
  call ExecCmd(l:command)
endfunction

function! ExecCmd(command)
  silent !clear
  execute "!echo " . a:command . " && " . a:command
endfunction

command! -nargs=* Taback :call Taback(<q-args>)
function! Taback(params)
  tabnew
  call Ack(a:params)
endfunction

function! ToggleMouseMode()
  let &mouse=(&mouse == "a"?"":"a")
  echo (&mouse == 'a') ? "MouseMode On" : "MouseMode Off"
endfunction

command! JasmineCompile :call JasmineCompile()
function! JasmineCompile()
  let l:command = "bundle exec rake sop_ui:jasmine_compile_template[" . expand('%:t:r') . "]"
  call ExecCmd(l:command)
endfunction

command! RenameFile :call RenameFile()
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
