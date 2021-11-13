call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'preservim/NERDTree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'arzg/vim-colors-xcode'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
call plug#end() 


" git gutter commands
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
""highlight SignColumn guibg=bg
""highlight SignColumn ctermbg=bg
set updatetime=250

""key mapping
let mapleader = " "
map <C-P> :Telescope find_files<CR>
nnoremap <leader>ps <cmd>Telescope live_grep<cr>
map <C-b> :NERDTreeToggle<CR>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Some automation
" Close nerdtree if only windows left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



"" VIM XCODE THEME"
colorscheme xcodedark
set termguicolors
augroup vim-colors-xcode
    autocmd!
augroup END

autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set ruler
set autoindent
set laststatus=2
set nowrap
set linebreak
set nolist
set noswapfile
set colorcolumn=80
nnoremap j gj
nnoremap k gk
let NERDTreeShowHidden=1


" Language servers "
lua << EOF
require'lspinstall'.setup() -- important
require('lsp_config')
--local servers = require'lspinstall'.installed_servers()
--for _, server in pairs(servers) do
--  require'lspconfig'[server].setup{ on_attach=require'completion'.on_attach }
--end

EOF
