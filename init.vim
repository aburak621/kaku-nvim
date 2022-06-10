"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" inoremap jk <ESC>
"
" syntax on " highlight syntax
" set number " show line numbers
" set noswapfile " disable the swapfile
" set hlsearch " highlight all results
" set ignorecase " ignore case in search
" set incsearch " show search results as you type
"
" " turn relative line numbers on
" set relativenumber
" set rnu
" " Disable compatibility with vi which can cause unexpected issues.
" set nocompatible
" " Enable type file detection. Vim will be able to try to detect the type of file in use.
" filetype on
" " Enable plugins and load plugin for the detected file type.
" filetype plugin on
" " Load an indent file for the detected file type.
" filetype indent on
" " Turn syntax highlighting on.
" syntax on
" " Set shift width to 4 spaces.
" set shiftwidth=4
" " Set tab width to 4 columns.
" set tabstop=4
" " Use space characters instead of tabs.
" set expandtab
" " Do not let cursor scroll below or above N number of lines when scrolling.
" set scrolloff=10
" " Override the ignorecase option if searching for capital letters.
" " This will allow you to search specifically for capital letters.
" set smartcase
" " Set the commands to save in history default number is 20.
" set history=1000
" " Enable auto completion menu after pressing TAB.
" set wildmenu
" " There are certain files that we would never want to edit with Vim.
" " Wildmenu will ignore files with these extensions.
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" " Make wildmenu behave like similar to Bash completion.
" set wildmode=list:longest
" set autoindent
" set mouse=a

" PLUGINS ---------------------------------------------------------------- {{{
" call plug#begin()
"
"     Plug 'joshdick/onedark.vim'
"     Plug 'preservim/NERDTree'
"     Plug 'itchyny/lightline.vim'
"     Plug 'https://github.com/ap/vim-css-color'
"     Plug 'sheerun/vim-polyglot'
"     Plug 'justinmk/vim-sneak'
"     Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"     Plug 'lilydjwg/colorizer'
"     Plug 'liuchengxu/vim-which-key'
"     Plug 'luochen1990/rainbow'
"     let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
"     Plug 'francoiscabrol/ranger.vim'
"     Plug 'mhinz/vim-startify'
"
" call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
    " inoremap jk <ESC>
    nnoremap <ESC> :nohlsearch<CR>
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
"augroup filetype_vim
"    autocmd!
"    autocmd FileType vim setlocal foldmethod=marker
"augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.
    " set laststatus=2
    "
    " if !has('gui_running')
    "     set t_Co=256
    " endif
    "
    " set noshowmode
" }}}

" syntax on
" colorscheme onedark
" highlight Normal ctermbg=Black

lua << EOF

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
require "user.renamer"
-- require "user.coq_nvim"

EOF
