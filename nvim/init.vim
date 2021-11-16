call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/NERDTree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'arzg/vim-colors-xcode'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'github/copilot.vim'
Plug 'eslint/eslint'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lukas-reineke/indent-blankline.nvim'
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
map <C-P> :lua require("telescope.builtin").find_files({hidden=true })<CR>
map <leader>gl <cmd>Telescope git_commits<CR> 
map <leader>gst <cmd>Telescope git_status<CR> 
map <leader>pc <cmd>Telescope commands<CR> 
nnoremap <leader>ps <cmd>Telescope live_grep<cr>
function VsCodeNerdToggle()
    if &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <C-b> :call VsCodeNerdToggle()<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
autocmd VimResized * wincmd =
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Some automation
" Close nerdtree if only windows left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set mouse=a
" THEME "
colorscheme gruvbox-flat

"" VIM XCODE THEME"
""colorscheme xcodedark
""set termguicolors
""augroup vim-colors-xcode
""    autocmd!
""augroup END
""
""autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
""autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

""syntax enable
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
set clipboard^=unnamed,unnamedplus
let NERDTreeShowHidden=1
set completeopt=menu,menuone,noselect
set ignorecase
set smartcase
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:.
set list
lua << EOF
  -- Setup nvim-cmp.
  local nvim_lsp = require('lspconfig')
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.api.nvim_buf_set_keymap["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }
  })


--  " Language servers "

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright',  'tsserver', 'gopls'}
for _, lsp in ipairs(servers) do
    if lsp == 'gopls' then
        nvim_lsp.gopls.setup {
            on_attach = on_attach,
            cmd = {"gopls", "serve"},
            settings = {
                gopls = {
                    analyses = {
                      unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        }
    else
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
                }
            }
    end
end

--
--require'lspinstall'.setup() -- important
--
--local servers = require'lspinstall'.installed_servers()
---- for _, server in pairs(servers) do 
----     require'lspconfig'[server].setup{ on_attach=require'completion'.on_attach }
----     require'lspconfig'[server].setup{ on_attach=require'diagnostic'.on_attach }
---- end
-- local local_on_attach = function(_, bufnr)
--     require'completion'.on_attach()
-- end
--
-- local map = function(type, key, value)
-- 	vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
-- end
-- 
-- local custom_attach = function(client)
-- 	print("LSP started init.");
--     require'completion'.on_attach(client)
-- 	map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
-- 	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
-- 	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
-- 	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
-- 	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- 	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
-- 	map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- 	map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
-- 	map('n','<leader>gW','<cmd>lua vimlsp.buf.workspace_symbol()<CR>')
-- 	map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
-- 	map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
-- 	map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
-- 	map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
-- 	map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- 	map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
-- 	map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
-- end
-- for _, server in pairs(servers) do
--     print("attaching to a server: ")
--     print(server)
--   require'lspconfig'[server].setup{ 
--        enable= true,
--     on_attach= custom_attach,
--     -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--   }
-- end
EOF



