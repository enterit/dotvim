" Make vim portable.
let $HOME=$VIM

" Load and run pathogen.
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" key binding for initializing youcomplete manually
" the plugin takes too much time to start, so let's initialize it only when necessary
noremap <F1> :call youcompleteme#Enable()<CR>

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

set nobackup
set noundofile
set nowritebackup

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

syntax on

set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

let g:onedark_termcolors=256
colorscheme onedark

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
au BufRead,BufNewFile *.as set filetype=actionscript
" set default font
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10

"Personal Settings.
"More to be added soon.
filetype plugin indent on
syntax on

set laststatus=2
set encoding=utf8

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols = {}
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1
set foldlevelstart=99

inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>
set autowriteall
set hidden
au BufLeave * upd
au BufLeave,FocusLost * silent! wall
au BufNewFile,BufRead *.groovy  setf groovy 

nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
set ignorecase
set smartcase
set textwidth=120
command Greview :Git! diff --cached
nnoremap <F4> "=strftime("%a, %d %b %Y %H:%M:%S")<CR>P
inoremap <F4> <C-R>=strftime("%a, %d %b %Y %H:%M:%S")<CR>
set columns=200
au GUIEnter * simalt ~x
command! -nargs=* Wrap set wrap linebreak nolist


" signify plugin settings
let g:signify_sign_show_count = 0
let g:signify_sign_change = '~'
let g:signify_vcs_list = [ 'git' ]

" use slash instead of backslash as path separator in windows
set shellslash

" ack plugin settings for search using ag

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackhighlight = 1

" Use space bar as a leader key
let mapleader = "\<Space>"
nnoremap <Space> <Nop>

" Do not move cursor when switching tabs
set nostartofline


" CtrlP plugin settings

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>o :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


" Buffer key bindings

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>


" show jsdoc popup window on the bottom, otherwise it shows up at the top and shifts current buffer down
set splitbelow


" key bindings for ack search
nnoremap <leader>a :Ack
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>


" key bindings for vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


" key bindings for browserlink plugin
vmap <silent><Leader>r :BLEvaluateSelection<CR>
nmap <silent><Leader>r :BLEvaluateBuffer<CR>


" mapped jj to escape
ino jj <esc>
cno jj <c-c>
