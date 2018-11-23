" disable compatibility with vi
set nocompatible
" default to case insensitive search
set ic
" turn on line numbers
set nu
" default encoding
set termencoding=utf-8
" do incremental searching
set incsearch
" keep 50 lines of command line history
set history=50
" show the cursor position all the time
set ruler
" immediate window update?
set updatetime=0
" no beeps
set novisualbell

" Copy/Pase using XA_SECONDARY (Ctrl-C/Ctrl-V buffer)
set clipboard=unnamedplus

" Let exit immediately on F10
nnoremap <F10> :q!<CR>
" and by F4
nnoremap <F4> :q!<CR>
" Save file and exit
" nnoremap <S-F10> :wq<CR>
" Save file
nnoremap <F2> :w<CR>

" Whitespace chars
set listchars=eol:§,tab:>-,trail:~,extends:>,precedes:<
noremap <C-h> :set list<CR>
noremap <C-H> :set list!<CR>

" statusline
set laststatus=2
set statusline=%<%f\ -\ Buffer:\ %2n[%M%R%W]\ \|\ \ Line-\ %5l[%3p%%]\ Column\ -\ %2c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a
set mousemodel=popup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set cursorline

set background=light
let g:solarized_termcolors=256
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap lines up/down functions
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

noremap <silent> <c-up> :call <SID>swap_up()<CR>
noremap <silent> <c-down> :call <SID>swap_down()<CR>

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  " let &t_SI = "\<Esc>]12;orange\x7"
  " let &t_SI .= "\<Esc>[5 q"
  " use a red cursor otherwise
  " let &t_EI = "\<Esc>]12;red\x7"
  " silent !echo -ne "\033]12;red\007\033[1 q"
  " reset cursor when vim exits
  " autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
  " let &t_EI .= "\<Esc>[1 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

" you can move the cursor one character over the end
" set virtualedit=onemore


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent " always set autoindenting on

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

" Comment/Uncomment (plugin)
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

