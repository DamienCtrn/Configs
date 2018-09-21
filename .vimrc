" Disable vi specifics commands
set nocompatible

" Vundle part {{{

" For Vundle to work correctly we need to disable it
filetype off

" Vundle settings {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" }}}

" Vundle plugins {{{

" Colorschemes
Plugin 'NLKNguyen/papercolor-theme'
" To be able to have nice git branches info in AirLine
Plugin 'tpope/vim-fugitive'
" File Explorer Plugin
Plugin 'scrooloose/nerdtree'
" Bottom bar plugin
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin to highlight word occurences
Plugin 'RRethy/vim-illuminate'
" Git utility (column of modifies added for expl)
Plugin 'airblade/vim-gitgutter'
" All of your Plugins must be added before the following line
" }}}

" Required for plugin indentation and filetype detection
call vundle#end()            " required
filetype plugin indent on    " required

" }}}

" Main configuration {{{

" Basic configuration {{{

" Number of spaces that a Tab produces
set tabstop=2
" Number of spaces that a Tab counts for while performing editing operations
set softtabstop=2
" To use backspace anytime
set backspace=2
" Number of spaces used for (auto)indent
set shiftwidth=2
" To keep the indentation when inserting new line
set autoindent
" To expand tabs into spaces
set expandtab
" Because who use Windows/MacOS ;)
set fileformat=unix
" UTF-8 support
set encoding=utf-8
" Line numbering
set number
" Set incremental search
set incsearch
" Allow the usage of mouse in every mode every time
set mouse=a
" Ajust update time for gitgutter plugin
set updatetime=100
" Maximum number of tabs to be safe
set tabpagemax=100
" Highlight the search results
set hlsearch
" Wildmenu for command completion
set wildmenu
" Shows the current command
set showcmd
" Setting splits to open right and below
set splitright
set splitbelow

" }}}

" Color scheme {{{

" Set syntax coloration
syntax on
" Set the number of color
set t_Co=256
" Set the background color
set background=dark
" Set the colorscheme

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \         'color00' : ['#000808', '257'],
  \         'linenumber_bg' : ['#000808', '257']
  \       }
  \     }
  \   },
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
colorscheme PaperColor

" C syntax additions to have nice highlight
let c_no_curly_error=1
let c_syntax_for_h=1


" }}}

" }}}

" Plugin configurations {{{

" NERDTree configuration {{{

" Ignore temp & compiled files with NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$']
" Replacing the arrow icons in NERDTree:
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"
" Remap Ctrl-N to NERDTreeToggle
nnoremap <C-n> :NERDTreeToggle<CR>
" Remap Ctrl-P to NERDTreeFind current folder
nnoremap <C-p> :NERDTreeFind<CR>
augroup NERDTree
    " Clean the group each time
    autocmd!
    " Close vim if the only tab remaining is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}

" Airline configuration {{{
set number
set laststatus=2
let g:airline_powerline_fonts = 1
" Others Airline nice Themes : simple minimalist jellybeans
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
" Powerline Symbols
let g:Powerline_symbols = 'fancy'
let g:Powerline_dividers_override = [[0xe0b0], [0xe0b1], [0xe0b2], [0xe0b3]]
let g:Powerline_symbols_override = {
  \ 'BRANCH': [0xe238],
  \ 'RO'    : [0xe0a2],
  \ 'FT'    : [0xe1f6],
  \ 'LINE'  : [0xe0a1],
\ }

" }}}

" }}}

" File type configurations {{{
" Python file settings {{{

augroup filetype_python
    autocmd!
    " Make the code look pretty
    autocmd FileType python let python_highlight_all=1
    " Fold based on indentation
    autocmd FileType python set foldmethod=indent
    " Fold everything when opening a Python file
    autocmd FileType vim setlocal foldlevel=0
augroup END

" }}}

" Vimscript file settings {{{

augroup filetype_vim
    autocmd!
    " For Vim files we use marker foldmethod
    autocmd FileType vim setlocal foldmethod=marker
    " Fold everything when opening a Vim file
    autocmd FileType vim setlocal foldlevel=0
augroup END

" }}}

" Latex file settings {{{

augroup filetype_latex
    " Clean the group each time
    autocmd!
    " When editing Latex file I prefer a shiftwidth of 2
    autocmd BufNewFile,BufRead *.tex set sw=2
augroup END

" }}}

" Pkg file settings {{{

augroup filetype_pkg
    autocmd!
    " Personal use: I want sh syntax for file with .pkg extension
    autocmd BufNewFile,BufRead *.pkg set syntax=sh
augroup END
    
" }}}

" Additionnal c syntax file formats {{{

augroup filetype_c
    autocmd!
    autocmd BufNewFile,BufRead *.i set filetype=c
augroup END

" }}}    

" }}}

" Custom mappings {{{

" Move lines or grp of lines up "°" or down ")"
nnoremap ) :m .+1<CR>==
nnoremap ° :m .-2<CR>==
vnoremap ) :m '>+1<CR>gv=gv
vnoremap ° :m '<-2<CR>gv=gv

" Enable folding with the spacebar
nnoremap <space> za

" Remap z/ to search inside the current screen
nnoremap <silent> z/ :set scrolloff=0<CR>VHoL<Esc>:set scrolloff=1<CR>``/\%V

" Map F10 to print which is the syntax group under the cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" To move between the splits without having too much trouble
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Left> <C-W><C-H>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>

" Leader key to Q (because ex mode is not really useful)
let mapleader="Q"

" Qev open a split to edit the vimrc
nnoremap <leader>ev :vsplit ~/.vimrc<CR>

" Qsv to source the vimrc
nnoremap <leader>sv :so ~/.vimrc<CR>

" Qu to lower case the current word
nnoremap <leader>u viwu

" QU to upper case the current word
nnoremap <leader>U viwU

" Q" to surround the current word with double quotes
nnoremap <leader>" viw<Esc>a"<Esc>bi"<Esc>lel

" Q' to surround the current word with simple quotes
nnoremap <leader>' viw<Esc>a'<Esc>bi'<Esc>lel

" Mapping to add a semi-colon at the end of a line
nnoremap <leader>; mWA;<Esc>`W

" To stop highlighting with Enter
nnoremap <CR> :noh<CR><CR>

" }}}

" Grep custom functions {{{

" Mapping to grep -R current WORD under cursor
nnoremap <leader>G :silent execute "grep! -R -I " . shellescape(expand("<cWORD>")) . " ."<cr>:redr!<cr>:copen 10<cr>

" Operator to grep -R in visual and normal mode
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    " Save the value of the register prior to the function execution
    let save_unnamed_register = @@

    " If it is a visual mode (not block nor line visual)
    if a:type ==# 'v'
        normal! `<v`>y
    " If it is a normal motion
    elseif a:type ==# 'char'
        normal! `[v`]y
    " Otherwise we do not treat it
    else
        return
    endif

    " Execute the grep -R -I with the escape of the considered string
    silent execute "grep! -R -I " . shellescape(@@) . " ."
    " To prevent the silent bug
    redraw!
    " Open the quickfix window
    copen 10

    " Restore the register
    let @@ = save_unnamed_register
endfunction


" }}}

" SpellCheck custom function {{{

" For the ToggleSpell function
let g:spellOn = 0

" Used to toggle spellchecking and highlight ill spelled words
function! s:ToggleSpell()
  if g:spellOn ==# 0
	setlocal spell
	highlight SpellBad ctermbg=red guibg=red
	let g:spellOn = 1
  else
	setlocal nospell
	let g:spellOn = 0
  endif
endfunction

" Map F6 to call this previous functions
nnoremap <F6> :call <SID>ToggleSpell()<CR>

" }}}

" Custom highlights {{{

" Highlight the extra whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red

" Define the extra whitespace as the one at the end of line for no reason
match ExtraWhitespace /\s\+$/


" }}}

" To prevent a bug with system clipboard on my computer do not mind
" set t_BE=
