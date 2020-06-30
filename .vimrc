" PLUGINS
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm.vim'
Plug 'joshdick/onedark.vim'
Plug 'ap/vim-css-color'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'frazrepo/vim-rainbow'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ycm-core/YouCompleteMe' 
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-signify'
call plug#end()

" Set encoding
set encoding=UTF-8

" POWERLINE FONTS
let g:airline_powerline_fonts = 1
" True Colours
"if (has("termguicolors"))
"	    set termguicolors
"endif

" Mouse

set ttymouse=sgr
set mouse=a
" Enable rainbow brackets
au FileType c,cpp,objc,objcpp,py,R call rainbow#load()

""""""""""""


" OneDark Theme
syntax on
set number

let g:airline_theme='onedark'

if (has("autocmd")) 
	augroup colorset
	      autocmd!
	          let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
	      autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
        augroup END
endif

colorscheme onedark




" NerdTree

autocmd VimEnter * NERDTree

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


