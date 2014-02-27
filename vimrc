let g:ruby_path = system('echo $HOME/.rbenv/shims') " speeds up viewing ruby code (apparently)

if has("autocmd")
  filetype plugin indent on

  autocmd! ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=red
  autocmd! BufWinEnter * match ExtraWhitespace /\s\+$\|\t\+$/
  autocmd! InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd! InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd! BufWinLeave * call clearmatches()

  autocmd! Filetype gitcommit setlocal spell textwidth=72

  au BufNewFile,BufRead *.ui set filetype=ruby
  au BufNewFile,BufRead *.md set filetype=markdown
  au BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd! BufRead,BufNewFile Gemfile setfiletype ruby

  autocmd! BufWritePost .vimrc source ~/.vimrc " reload vim file when its saved
endif

syntax enable
set t_Co=256              " Set 256 colours
colorscheme wombat256mod

set colorcolumn=80        " Add bar at 80 chars wide

highlight ColorColumn ctermbg=black
highlight TabLineFill ctermfg=black

set backspace=2           " Delete key works to beginning of line
set tabstop=2             " Tab is 2 chars long
set shiftwidth=2          " Indent/Outdent by 2 spaces
set expandtab             " Use spaces instead of tab

" set relativenumber        " Displays relative line numbers
set number                " Displays line numbers

set wildmode=longest,list
set wildmenu              " Enable bash <tab><tab> to list dir

set incsearch             " Show match when typing
set hlsearch              " Highlight all search matches

set autoindent

set scrolloff=5           " Scroll lines before edge of screen
set scrolljump=5           " Scroll lines before edge of screen
set nowrap                " Don't wrap text
set laststatus=2          " Always show status bar
set lazyredraw            " Dont redraw between marcos
set timeoutlen=500        " Time to wait for second key press

set backupdir=~/.vim/tmp  " Store backups in same dir
set directory=~/.vim/tmp  " Store swps in same dir


" Netrw
let g:netrw_banner = 0 " Dont show banner
let g:netrw_liststyle=0

"map leader to , and \
map , \

" TODO
" tmux send-keys -t:3 'ls' Enter; tmux select-window -t:3

" Insert Mode Mappings
imap § <ESC>

" Command mode
" Ctrl-A will go to the beginning
cnoremap <C-A> <Home>

" Normal Mode Mappings

nmap <S-k> :!<CR>

" Be consistant with D,C,S keys
nnoremap Y y$
nmap <leader>b :call InsertDebugger()<CR>
nmap <leader>dd :call InsertDebugger()<CR>
" nmap <leader>< :norm ggVGg?<CR>
" nmap <leader>def :Ack "def \\|private" <C-r>%<CR>
" nmap <leader>desc :Ack "describe " <C-r>%<CR>
nmap <silent><leader>f :NERDTreeToggle<CR>
nmap <leader>nn :set number!<CR>
nmap <leader>p :call Paste()<CR>
" nmap <leader>ss :setlocal spell!<CR>:echo "SpellChecker ="&spell<CR>
nmap <leader>s :FindFile 

nmap <silent><leader>gb :call GitBlame()<CR>

" Show git status
nmap <silent><leader>gs :echo system("git status")<CR>

" Run test on the whole file
nmap <silent><leader>tf :call RunTest(' -- '. @%)<CR>

" Run tests on the current line
nmap <silent><leader>tt :call TestLine()<CR>

" Run the last test again
nmap <leader>tl :call ExecCmd(g:command)<CR>

nmap <leader>lc :call LatexCompile()<CR>
command! LatexCompile :call ExecCmd("pdflatex " . @%)<CR>

" nmap <F6> :set wrap!<CR> :echo "Wrap Lines ="&wrap<CR>
nmap <F7> :! ruby app.rb<CR>


" All modes
map <F12> :call ToggleMouseMode()<CR>


" Save the current open windows
command! SaveSession mksession! ~/.vim/vim_session

" Load the last saved session
command! LoadSession source ~/.vim/vim_session

function! InsertDebugger()
  if(&filetype == 'ruby')
    :normal orequire 'pry'; binding.pry
  else
    :normal odebugger
  endif
  :normal ==
endfunction

function! TestLine()
  let l:command =  "-f documentation -l " . line(".") . ' ' . @%
  call RunTest(l:command)
endfunction

function! RunTest(command)
  let g:command = (system("pgrep zeus") != '') ? "zeus " : "bundle exec "
  " let g:command = call system('[ -f ./bin/rspec ] && echo "./bin/"')
  " let g:command = './bin/'
  let g:command .= 'rspec --profile --fail-fast ' . a:command
  call ExecCmd(g:command)
endfunction

function! GitBlame()
  let l:p = -3 + line('.')
  let l:n = 3 + line('.')
  let l:command = "git blame " . @% . " -w -L " . l:p . "," . l:n
  echo system(l:command)
endfunction

function! ExecCmd(command)
  silent !clear
  execute "!echo " . a:command . " && " . a:command
endfunction

command! Paste :call Paste()
function! Paste()
  set paste
  normal o
  " Paste from clipboard
  let @a=substitute(@*, "\\s\\+\\n", "\n", "ge") | normal "ap
  set nopaste
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

command! -nargs=* FindFile :call FindFile(<q-args>)
function! FindFile(str)
  let l:ostr = split(a:str)
  let l:str = split(a:str)
  call map(l:str, '".*\\+" . v:val . ""')
  call add(l:str, '.*')
  let l:regex = join(l:str,'')

  let l:command = "for i in `git ls-files -z | xargs -0 ls  -t | grep '" . l:regex . "'`; do echo $i':1: '; done;"

  cex system(l:command)
  cope

  highlight MySearch ctermbg=darkgreen guibg=darkgreen
  execute 'match MySearch /\((' . l:ostr[0] . ' )@!.\)\{-}\zs' . l:ostr[0] . '/'
  let c = 1
  while c <= len(l:ostr)-1
    call matchadd('MySearch', '\((' . l:ostr[c-1] . ')@!.\)\{-}' . l:ostr[c-1] . '.\{-}\zs' . l:ostr[c])
    let c += 1
  endwhile
endfunction
