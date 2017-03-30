" Stefan Rimola
" 2017

" - Pathogen {{{
execute pathogen#infect()
" }}}

" - Vim-centric config {{{
set hlsearch " highlight searches
set incsearch " incremental search
" set tabstop=2 " number of space of tab char
" set shiftwidth=2 " number of spaces to (auto)indent
set numberwidth=4 " set line numbers to 4 spaces
set autoread " set auto read when a file is changed externally
set ignorecase " ignore case when searching
" set cindent " C style indentation
set lazyredraw " performance config
set encoding=utf8 " set utf8 as standard encoding
set nobackup " turn backup off, since most is in VCS
set nowb " turn backup off
set noswapfile " turn backup off
set ai " auto indent
set wrap " wrap lines
set linebreak " only wrap at certain characters
set nolist " list disables linebreak
set textwidth=0 " prevent Vim automatically inserting line breaks
set wrapmargin=0 " prevent Vim automatically inserting line breaks
set fo=qrn1 " wrap long lines
set expandtab " use spaces instead of tabs
set smarttab "enable smart-tabs
set softtabstop=2 " number of spaces per tab (again)
set wildmenu " show autocomplete menus
set foldenable " enable folding
set foldmethod=indent " fold based on indent level
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set so=20 " scroll offset above and below cursor
set numberwidth=6 " set width of line number gutter
set nocompatible " don't try to be compatible with vi
set modelines=1 " allow folding in vimrc using modeline magic
set undofile " Undo previous changes when opening a file
set undodir=~/.vim/undo/
set hidden " Allow buffer switching without saving changes
set clipboard=unnamed " allow cut and paste operations to work with system clipboard
set indentkeys-=0{ " don't move { character to start of line

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" when searching, look in current file's directory, then current directory,
" then each directory under current
set path=.,,**

" Reload when entering buffer or gaining focus
au FocusGained,BufEnter * :silent! !
" }}}

" - Key mappings {{{
map ; :
noremap ;; ;
nnoremap j gj
nnoremap k gk

" map ctrl+t to new split and open ctrlp
nnoremap <C-t> :vs<cr><C-w>l <bar> :CtrlP<cr>

" map ctrl+{nav} to split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" map w!! to save file if you forget to sudo
cmap w!! w !sudo tee % >/dev/null

" Damian Conway's Die Blinkënmatchen: highlight matches {{{
nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction
" }}}

" leader mappings {{{

" Remap <leader> - originally "\"
let mapleader="," " map leader to comma

" map double-delete to remove all whitespace from current file
nnoremap <silent> <BS><BS> :%s/\s\+$//<cr>:let @/=''<CR>

" map ,<DEL> to convert all tabs to 2 spaces
nnoremap <leader><bs> :%s/\t/  /g<cr>

" ,w to close buffer safely
nmap <leader>w :bp<CR>:bdelete #<CR>

" ,ev to open and edit vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" ,ec to open and edit colorscheme
nnoremap <leader>ec <C-w><C-v><C-l>:e ~/.vim/colors/lok1vip.vim<cr>

" map ,n and ,m to buffer previous and buffer next
map <leader>m :bn<CR>
map <leader>n :bp<CR>
" Remap nerdtree toggle
map <Leader>t :NERDTreeToggle<CR>

" map ,p to autoinsert a prettydump
map <leader>p :startinsert<cr>{{ prettydump(<esc>a
" }}}

" kill arrow keys {{{
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

" }}}

" - File settings {{{
filetype plugin on " enable filetype specific plugins
filetype indent on " enable filetype specific indentation

" }}}

" - Plugin settings{{{

" Change indent Char for IndentLine plugin
let g:indentLine_char = '┊'

" Circumvent indentLine's aggressive concealing
let g:indentLine_concealcursor=""

" Use htmljinja syntax highlighting for twig files
au BufRead,BufNewFile *.twig set filetype=jinja
" - Airline settings {{{
let g:airline_theme='term'
let g:airline_powerline_fonts = 1 " populate airline_symbols with powerline symbols
set laststatus=2
let g:airline#extensions#tabline#enabled = 1 " show list of buffers when there is only one tab
let g:airline#extensions#tabline#buffer_nr_show = 1 " show buffer number
" }}}

" - Nerdcommenter settings {{{
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}

" - GitGutter settings {{{
let g:gitgutter_enable = 1 " enable gitgutter by default
set updatetime=3000 " check for updates every 3 seconds
" }}}

" - NERDTree settings {{{
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 35
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeIgnore = ['node_modules[[dir]]', 'build[[dir]]', 'assets[[dir]]', 'vendor[[dir]]', '.git[[dir]]', '.vagrant[[dir]]', '.idea[[dir]]', '\.DS_Store$', '\.amp$']
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeFileExtensionHighlightFullName = 1 " NERDTree file extension highlighting
let g:NERDTreeShowHidden = 1
let g:NERDTreeCascadeOpenSingleChildDir = 1
" }}}

" - vim-closetag settings {{{
let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.twig,*.hbs"
" }}}

" - Syntastic settings {{{
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1
" }}}

" - Ctrlp settings {{{
let g:ctrlp_map = '<c-o>' " remap ctrlp to ctrl+o
let g:ctrlp_dont_split = 'NERD'
set wildignore+=*/vendor/**
set wildignore+=*/build/**
set wildignore+=*/assets/**
set wildignore+=*/node_modules/**
" make ctrlp search regex match and replace space with .*
let g:ctrlp_regexp = 1
let g:ctrlp_abbrev = {
\ 'gmode': 't',
\ 'abbrevs': [
\ {
\ 'pattern': ' ',
\ 'expanded': '.*',
\ 'mode': 'pfrz'
\ },
\  ]
\ }
" }}}
" }}}

" - Apply vim config changes without restart {{{
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" }}}

" - Recursively create directory on save if it doesn't exist {{{
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}

" - UI Config {{{
syntax enable
set background=dark
if !has('gui_running')
  colorscheme lok1vip
else
  colorscheme material-theme
endif
set number " show line numbers
set relativenumber " show relative line numbers
set ruler " show cursor position
set cursorline " show location of cursor with horizontal line

" set guifont for nerd icons
set guifont=DroidSansMonoForPowerline\ Nerd\ Font

" show ColorColumn when text is bleeding over
call matchadd('ColorColumn', '\%81v', 100)

" }}}

" vim:foldmethod=marker:foldlevel=0
