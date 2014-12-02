" Pathogen (loads all plugins from .vim/bundle)
" Pathogen should be in .vim/autoload
execute pathogen#infect()

" Environment
set noswapfile
set nobackup
set history=100
set viminfo+=:100
set viminfo+=/100
set incsearch
set ignorecase smartcase
set hlsearch
set showmatch
set matchtime=2
set iskeyword=@,48-57,_,192-255
set visualbell
set ttyfast
set nocompatible
set directory=./.backup,/tmp,.

" Editor
set nowrap
set showbreak=>.
set tabstop=2
set expandtab
set shiftwidth=2
" set autoindent
set cindent
" t: autowrap text using textwidth
" l: long lines are not broken in insert mode
" c: autowrap comments using textwidth, inserting leader
" r: insert comment leader after <CR>
" o: insert comment leader after o or O
set formatoptions-=to
set formatoptions+=lcr
set textwidth=120
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray
set scrolloff=3
set whichwrap=b,s,>,<,],[
set backspace=indent,eol,start

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le

" Layout
set number
set numberwidth=3
set mouse=a
set foldenable
set foldcolumn=2
set foldmethod=indent

set showmode
set showcmd
set laststatus=2  " Always
set showtabline=2 " Always
set winminheight=0
set winheight=9999
set ruler
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P
set shortmess=atTIAW
set pumheight=12
set timeoutlen=800

" Buffers
set noequalalways
set switchbuf=useopen

syntax on
filetype on
filetype plugin on
filetype indent on


" Features:

" Reindent all file <Alt> + =
nnoremap <Esc>= mzgg=G`z
inoremap <Esc>= <Esc>mzgg=G`za
vnoremap <Esc>= <Esc>mzgg=G`zgv

" Moving lines(Alt+Shift+j/k)
nnoremap <Esc>K :m-2<CR>==
inoremap <Esc>K <Esc>:m-2<CR>==gi
vnoremap <Esc>K :m '<-2<CR>gv=gv
nnoremap <Esc>J :m+<CR>==
inoremap <Esc>J <Esc>:m+<CR>==gi
vnoremap <Esc>J :m '>+1<CR>gv=gv

" Menu
set wildmenu
set wildmode=list:longest,full

set wcm=<Tab>
menu Exec.PHP  :!php % <CR>
menu Exec.bash      :!/bin/bash<CR>
map <F9> :emenu Exec.<Tab>

" whitespaces
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
set lcs=trail:·,tab:>–,precedes:<,extends:>
match ExtraWhitespace /\s\+$/
" clear trailing spaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
"autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" TODO: exclude file formats, where trailings are meaningful

" Comments toggle
let s:comment_map = {
      \   "c": '//',
      \   "cpp": '//',
      \   "go": '//',
      \   "java": '//',
      \   "javascript": '//',
      \   "php": '//',
      \   "python": '#',
      \   "ruby": '#',
      \   "vim": '"',
      \   "conf": '#',
      \   "apache": '#'
      \ }
function! ToggleComment()
  echo &filetype
  if has_key(s:comment_map, &filetype)
    let comment_leader = s:comment_map[&filetype]
    if getline('.') =~ '^\s*' . comment_leader . ""
      execute 'silent s:^\(\s*\)' . comment_leader . '\(\s*\):\1:'
      echo 'Uncommented'
    else
      execute 'silent s:^\(\s*\):\1' . comment_leader . ' :'
      echo 'Commented'
    endif
  else
    echo 'Unknown filetype for commenting'
  end
endfunction
" Map to Ctrl+/
nnoremap  :call ToggleComment()<cr>==
inoremap  <Esc>:call ToggleComment()<cr>==gi
autocmd BufNewFile,BufRead *.html setlocal commentstring=<!--%s-->
autocmd FileType ruby setlocal commentstring=#%s

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif
set diffopt=filler
set diffopt+=context:4
set diffopt+=iwhite
set diffopt+=vertical

" Highligting
set  t_Co=256
set background=dark

"
" PHP
"php syntax options
let php_sql_query = 1
let php_htmlInStrings = 1
let php_baselib = 1
"let php_parent_error_close = 1
"let php_parent_error_open = 1
"let php_oldStyle = 1
"let php_noShortTags = 1
let php_folding = 1
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
" php syntax check \ps
autocmd FileType php nmap <Leader>ps :!php -l %<CR>
" php run current buffer \pr
autocmd FileType php nmap <Leader>pr :!php % \| less -F<CR>

" Some bindings
nnoremap  :bp!<CR>
inoremap  <Esc>:bp!<CR>
nnoremap  :bn!<CR>
inoremap  <Esc>:bn!<CR>
nnoremap  :bw!<CR>
inoremap  <Esc>:bw!<CR>

" Plugins:
" NERDTree
map  :NERDTreeToggle<CR>

