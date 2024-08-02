" vim:set ts=2 sts=2 sw=2 expandtab:
" NOTE: Install Vim Plug (instructions at `junegunn/vim-plug`)
" Run: `mkdir -p $HOME/.vim/.{undo,backup,swp}`
call plug#begin()
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-fugitive'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mbbill/undotree'
  Plug 'morhetz/gruvbox'
  Plug 'github/copilot.vim'
call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set ignorecase
set smartcase

syntax on
filetype plugin indent on
set autoread

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

set cursorline
set ruler
set colorcolumn=80
set incsearch
set hlsearch
set number
set relativenumber

set timeoutlen=500 "http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set updatetime=50
set ttyfast

set nowrap
set scrolloff=8     "better scrolling
set sidescrolloff=8 "better scrolling
set splitright "vsplit put the new buffer on the right of the current buffer
set splitbelow "split put the new buffer below the current buffer
set encoding=utf-8
set completeopt="menuone,noselect"

set list
set listchars=tab:»·,trail:·,nbsp:␣

" colors
set termguicolors
set t_Co=256
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme gruvbox

"neovim guicursor
"default : "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
"set guicursor=v-c-sm:block,n-i-ci-ve:ver25,r-cr-o:hor20
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
" use a line cursor within insert mode and a block cursor everywhere else.
"
" reference chart of values:
"   ps = 0  -> blinking block.
"   ps = 1  -> blinking block (default).
"   ps = 2  -> steady block.
"   ps = 3  -> blinking underline.
"   ps = 4  -> steady underline.
"   ps = 5  -> blinking bar (xterm).
"   ps = 6  -> steady bar (xterm).
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
let &t_SR = "\e[3 q"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" undo
set undofile
set undodir=~/.vim/.undo/
set backupdir=~/.vim/.backup/
set directory=~/.vim/.swp/

" mappings
let mapleader = " " "map leader to space

" disable highlights
map <silent> <leader><cr> :noh<cr>

" toggle spell checking
map <leader>s :setlocal spell!<cr>

" easy write/quit
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>Q :qa!<cr>

"global yank
vnoremap <silent> <leader>y "+y :let @+=@*<cr>
vnoremap <silent> <leader>Y "+Y :let @+=@*<cr>
" paste without losing the buffer
xnoremap <leader>p "_dP

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" no Ex mode
nmap Q <nop>

" better movement
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap < <gv
vnoremap > >gv

" move highlighted lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" keep J intact when joining lines
nnoremap J mzJ`z

" location list
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz

" netrw
nnoremap <c-p> :Lexplore<cr>
function! NetrwMapping()
  nmap <buffer> n % "edit new file
  nmap <buffer> r R "rename file
  nmap <buffer> H u "back in history
  nmap <buffer> h -^ "up a directory
  nmap <buffer> l <cr> "open a directory or a file
  nmap <buffer> . gh "toggle the dotfiles
  nmap <buffer> P <C-w>z "close the preview window
  nmap <buffer> L <cr>:Lexplore<cr> "open a file and close netrw
  nmap <buffer> <leader>q :Lexplore<cr> "close netrw
endfunction

augroup netrw_mapping
  au!
  au filetype netrw call NetrwMapping()
augroup END

" fugitive
nnoremap <leader>gi :Git<cr>
" always rebase
nnoremap <leader>gp :Git pull --rebase <cr>
" allows me to easily set the branch I am pushing and any tracking
nnoremap <leader>gP :Git push -u origin <cr>
nnoremap <leader>gb :Git blame<cr>
" best diff tool
nnoremap <leader>gd :Gdiffsplit!<cr>
nnoremap <leader>gh :diffget //2<cr> "left
nnoremap <leader>gl :diffget //3<cr> "right

" fzf
nnoremap <leader>sf :GFiles<cr>
nnoremap <leader>sF :Files<cr>
nnoremap <leader>sb :Buffers<cr>
nnoremap <leader>sg :Rg<cr>

" undotree
nnoremap <leader>u :UndotreeToggle<cr>

" jump to last edit position on opening file
augroup RestoreCursor
  au!
  au BufReadPost *
    \ let line = line("'\"")
    \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \ |   execute "normal! g`\""
    \ | endif
augroup END

" LSP
" asyncomplete
inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup()        : "\<C-y>"
inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup()       : "\<C-e>"
"snippets
imap <expr> <C-l> vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>'
smap <expr> <C-l> vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-l>'
imap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <C-l> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-l>'
smap <expr> <C-l> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-l>'
imap <expr> <C-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-h>'
smap <expr> <C-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-h>'

" inlay hints
let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_mode = {
  \ 'normal': ['always']
\}

augroup lsp_register_server
  au FileType python let g:lsp_settings_filetype_rust = ['rust-analyzer']
augroup END

function! LspToggle()
  let l:buf = bufnr('%')
  if lsp#internal#diagnostics#state#_is_enabled_for_buffer(l:buf)
    call lsp#disable_diagnostics_for_buffer(l:buf)
  else
    call lsp#enable_diagnostics_for_buffer(l:buf)
  endif
endfunction

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gD <plug>(lsp-declaration)
  nmap <buffer> <leader>ss <plug>(lsp-document-symbol-search)
  nmap <buffer> <leader>sS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> <leader>D <plug>(lsp-type-definition)
  nmap <buffer> <leader>ca <plug>(lsp-code-action-float)
  nmap <buffer> <leader>cr <plug>(lsp-rename)
  nmap <buffer> <leader>sd <plug>(lsp-document-diagnostics)
  nmap <buffer> <expr> <leader>ct LspToggle()
  nmap <buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <leader>f LspDocumentFormatSync()
  nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><c-b> lsp#scroll(-4)
  inoremap <buffer> <expr><c-f> lsp#scroll(+4)
  inoremap <buffer> <expr><c-b> lsp#scroll(-4)

  " format
  let g:lsp_format_sync_timeout = 1000
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

packadd! matchit
