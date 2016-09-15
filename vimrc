" Make vim portable.
if ($OS == 'Windows_NT')
    " Windows specific settings
    let $HOME=$VIM
endif


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
    set norelativenumber
  else
    set nonumber
    set relativenumber
  endif
endfunc

nnoremap <F7> :call NumberToggle()<cr>

syntax on

set term=xterm
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

if ($TERM == 'xterm-256color')
    set t_Co=256
    let g:onedark_termcolors=256
else
    set t_Co=16
    let g:onedark_termcolors=16
endif

colorscheme onedark
let g:airline_theme='onedark'

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
if ($OS == 'Windows_NT')
    " Windows specific settings
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10
else
    " Unix specific settings
    set guifont=Roboto\ Mono\ for\ Powerline\ 10
endif


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
nmap <silent><Leader>r :BLEvaluateParagraph<CR>
nmap <silent><Leader>R :BLEvaluateBuffer<CR>
let g:bl_no_autoupdate = 1

" mapped jj to escape
ino jj <esc>
cno jj <c-c>


" Use gvim for fugitive when it is called from gvim.
" Otherwise vim is called from Git MSYS console, which breaks xterm colors.
if has("gui_running")
    let g:fugitive_git_executable = 'set GIT_EDITOR=gvim && git'
endif


" do not map default bindings for windowswap, since <leader>pw slows down <leader>p that is preferrable for NERDTree
" <leader>pw is deprecated anyways
let g:windowswap_map_keys = 0
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>


" key bindings for NERDTree
nmap <silent> <Leader>p :NERDTreeToggle<CR>
" disable left-hand scroll in gui vim, since it causes gvim window to jump and resize
" when NERDTree shows up
:set guioptions-=L


" Map the Y key to y$, so that it behaves the same as D and C.
" This should happen after yankstack plugin is initialized.
call yankstack#setup()
nmap Y y$
" Make it possible to use Alt-.. combinations in gvim. By default they are bound to menus.
set winaltkeys=no
" Disable autopairs Alt-P mapping, so it could be used by yankstack plugin.
let g:AutoPairsShortcutToggle = ''


" key bindings for search highlight removing
map <silent> <leader><cr> :noh<cr>


function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" Yank to clipboard by default.
" From http://stackoverflow.com/questions/13380643/vim-use-as-default-register-only-for-yank-command
:nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
:nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'
:nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
:xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
:xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
