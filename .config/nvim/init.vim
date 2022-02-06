syntax on
filetype plugin indent on
" added on 5/5/2020
set nocompatible
filetype plugin on

let plugpath = '~/.vim/bundle'

if has('nvim')
  let plugpath = '~/.config/nvim/bundle'
endif

if has('vim')
  if !empty($STY)
    set term=screen-256color
  endif
endif

" removed for urxvt
"set termguicolors

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" if ! empty(glob('~/.config/coc/extensions/node_modules/coc-pairs'))
"   autocmd VimEnter * CocUninstall coc-pairs
" endif

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 call plug#begin(plugpath)
   Plug 'http://github.com/tpope/vim-surround.git'
   Plug 'http://github.com/tpope/vim-commentary.git'
   " Plug 'vimwiki/vimwiki'
   " Plug 'vim-pandoc/vim-pandoc' " Markdown Docs in Vim
   " Plug 'vim-pandoc/vim-pandoc-syntax' " Markdown Docs in Vim
   Plug 'http://github.com/svermeulen/vim-subversive.git' " search and replace tool
   Plug 'http://github.com/bronson/vim-trailing-whitespace.git' " remove trailing whitespace
   Plug 'bluz71/vim-nightfly-guicolors'

" dev plugins
   " Plug 'neovim/nvim-lspconfig' " navtive nvim langauge server
   " Plug 'nvim-lua/diagnostic-nvim'
   " Plug 'nvim-lua/lsp-status.nvim'
   " Plug 'nvim-lua/completion-nvim'
   " Plug 'ycm-core/YouCompleteMe' "coc alternative for language server
   Plug 'http://github.com/vim-syntastic/syntastic.git' "syntax checker for languages
   Plug 'http://github.com/dense-analysis/ale.git' " code linter

   if has('nvim')
     Plug 'neoclide/coc.nvim', {'branch': 'release'}
     Plug 'udalov/kotlin-vim' " kotlin syntax highlighting
     if has('nvim-0.5')
       Plug 'nvim-treesitter/nvim-treesitter'
     endif
     " Plug 'fwcd/kotlin-language-server', { 'do': './gradlew :server:installDist' } " kotlin language sesrver
     " Plug 'http://github.com/rust-lang/rust.vim.git'
     Plug 'http://github.com/neovimhaskell/haskell-vim.git' " what does this do?
     " Plug 'http://github.com/fsharp/vim-fsharp.git', { 'for': 'fsharp', 'do':  'make fsautocomplete' }
   endif
   Plug 'sbdchd/neoformat' " for formatting code
   Plug 'http://github.com/alvan/vim-closetag.git' "closing tags for html
   " Plug 'http://github.com/prettier/vim-prettier.git', { 'do': 'yarn add prettier' }
   " Plug 'nvim-treesitter/completion-treesitter'
   " Plug 'nvim-treesitter/playground'

   " Plug 'http://github.com/c-brenn/repel.nvim.git'
   Plug 'http://github.com/scrooloose/nerdtree.git' " file manager for vim
   " Plug 'Xuyuanp/nerdtree-git-plugin' " git integration for nerd tree
   Plug 'unblevable/quick-scope'                  "  color movements
   Plug 'http://github.com/dhruvasagar/vim-zoom.git' "zoom window
   Plug 'http://github.com/easymotion/vim-easymotion.git' " improvements for motions
   Plug 'http://github.com/tpope/vim-fugitive.git'  " git integration for vim
   Plug 'airblade/vim-gitgutter'  " shows git status in the gutter of vim
   Plug 'norcalli/nvim-colorizer.lua' " tool to show colors in vim r,g,b
   Plug 'tpope/vim-abolish'
   " Plug 'MikeCoder/quickrun.vim'
   " Plug 'dracula/vim', { 'name': 'dracula' }  " theme
   " Plug 'benmills/vimux' " tmux integration
   " Plug 'kovetskiy/sxhkd-vim'
   Plug 'http://github.com/ryanoasis/vim-devicons'
   Plug 'http://github.com/vim-airline/vim-airline.git' " line manager
   Plug 'http://github.com/vim-airline/vim-airline-themes' " theme for the airline line manager
   " Plug 'dracula/vim', { 'as': 'dracula' }
   " Plug 'http://github.com/itchyny/lightline.vim.git'    "line manager
   Plug 'mhinz/vim-startify' " start screen for vim
   " Plug 'voldikss/vim-floaterm' " embedded terminal
   " Plug 'terryma/vim-multiple-cursors'
   Plug 'mg979/vim-visual-multi', {'branch': 'master'} " block selectio
   " Plug 'liuchengxu/vim-which-key'
   Plug 'justinmk/vim-sneak'
   " sneak
 call plug#end()

source $HOME/.config/nvim/plug-config/ale.vim
source $HOME/.config/nvim/plug-config/coc/coc.vim
source $HOME/.config/nvim/plug-config/coc/coc-extensions.vim
source $HOME/.config/nvim/plug-config/git-gutter.vim
source $HOME/.config/nvim/plug-config/easymotion.vim
source $HOME/.config/nvim/plug-config/sneak.vim
source $HOME/.config/nvim/plug-config/startify.vim
source $HOME/.config/nvim/plug-config/commentary.vim
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/syntastic.vim

if has('nvim-0.5')
  luafile $HOME/.config/nvim/plug-config/treesitter.lua
endif


" Neovim LSP setup
" lua <<EOF
"   require'nvim_lsp'.gopls.setup{}
"   require'nvim_lsp'.bashls.setup{
"  log_level = vim.lsp.protocol.MessageType.Log;
"  message_level = vim.lsp.protocol.MessageType.Log;
"   }
"   require'nvim_lsp'.rust_analyzer.setup{}
"   require'nvim_lsp'.tsserver.setup{}
"   require'nvim_lsp'.kotlin_language_server.setup{}
"   require'nvim_lsp'.yamlls.setup{
"     filetypes = { "yaml", "yml" }
"   }
"   require'nvim_lsp'.hls.setup{
"   cmd = {"haskell-language-server", "--lsp"};
"   init_options = {
"    languageServerHaskell = {
"      hlintOn = true;
"      formattingProvider = "ormolu";
"      diagnosticsOnChange = false;
"    }
"   }
" }
" EOF

" let g:ale_filetype_blacklist = [
" \   'nerdtree',
" \   'tags',
" \]


" autocmd VimLeavePre * :call coc#rpc#kill()
" autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif

" let g:lightline = {
"       \ 'colorscheme': 'darcula',
"       \ }


" Neovim default
"let g:Hexokinase_highlighters = [ 'virtual' ]
" let g:Hexokinase_highlighters = [ 'sign_column' ]
" " All possible values
" let g:Hexokinase_optInPatterns = [
" \     'full_hex',
" \     'triple_hex',
" \     'rgb',
" \     'rgba',
" \     'hsl',
" \     'hsla',
" \     'colour_names'
" \ ]

autocmd Filetype markdown,vim let b:autopairs_enabled = 0

autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd FileType vim let b:coc_pairs_disabled = ['"']

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
" let g:closetag_filetypes = 'html,js'

"
" let g:MyAltKey = '<Esc>'
" let g:AutoPairsShortcutToggle = 'M-p'
" let g:AutoPairsShortcutToggle = '<leader>"'

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" ctrlp
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'

" open NERDTree automatically
" autocmd VimEnter * NERDTree

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<cr>

" Show line numbers and relative numbers
set number relativenumber

" yank to the plus register
" set clipboard=unnamedplus " yank to '+' register
" set clipboard+=unnamedplus
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Show file statistics
set ruler

" Blink cursor on error instead of beeping
set visualbell

set fixendofline

" White space
set wrap
set tabstop=4
set shiftwidth=2
set softtabstop=4
set expandtab
set noshiftround

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" \ is the leader key
" space key is the leader key
let mapleader=" "

" Map leader space clears search
map <leader><space> :let @/=''<cr>

" Map <leader>* to 'search for duplicates of this exact line'
nnoremap <leader>* 0y$/\V<c-r>"<cr>

" Map leader to write a root
noremap <leader>W :w !sudo tee % > /dev/null

"colorscheme 256-jungle
"colorscheme darkblue
"source $HOME/.config/nvim/pack/plugins/start/dracula/autoload/dracula.vim
"source $HOME/.config/nvim/autoload/dracula.vim
try
  colorscheme dracula
  " colorscheme nightfly
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme evening
endtry

" Enable scrolling via mouse
" if has('mouse')
"   set mouse=a
" endif
" disable mouse scrolling?
set mouse-=a

" set gfn=Source\ Code\ Pro:h15

" disable spellcheck
set nospell

" Enable folding
set foldmethod=manual

set tags=tags

" Use 256 colors
set t_Co=256

" Always show statusline
set laststatus=2

" Disable Arrow keys in NORMAL mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" disable arrow keys in VISUAL mode
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" Disable Arrow keys in INSERT mode
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

if exists(":PrettierAsync")
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
endif

autocmd BufRead .zshrc set filetype=sh
autocmd BufRead .zshenv set filetype=sh
autocmd BufRead .zshrc-work-custom set filetype=sh
autocmd BufRead .alias-master set filetype=sh
autocmd BufRead .alias-neovim set filetype=sh
autocmd BufRead .alias-bsd set filetype=sh
autocmd BufRead .xinitrc set filetype=sh
autocmd BufRead xmobarrc set filetype=haskell
autocmd BufRead Gemfile set filetype=ruby
autocmd BufRead Vagrantfile set filetype=ruby
autocmd BufRead Berksfile set filetype=ruby
" autocmd BufRead Dockerfile set filetype=ruby
"autocmd BufWritePre .zshrc %s/\s\+$//e
if exists(":FixWhitespace")
  autocmd BufWritePre .zshrc,*.sql,*.sh,*.kt,*.java,*.json,.vimrc FixWhitespace
endif

let g:haskell_enable_quantification = 1

" normal mode Easy filetype switching
nnoremap ftm :set ft=markdown<cr>
nnoremap ftp :set ft=python<cr>
nnoremap ftw :set ft=wiki<cr>
nnoremap ftr :set ft=ruby<cr>
nnoremap ftrs :set ft=rst<cr>
nnoremap ftv :set ft=vim<cr>
nnoremap ftj :set ft=javascript<cr>
nnoremap fts :set ft=sql<cr>
nnoremap ftsh :set ft=sh<cr>
nnoremap ftc :set ft=css<cr>
nnoremap fth :set ft=html<cr>
" nmap ,md :set ft=markdown<cr>

" g:pantondoc_use_pandoc_markdown default value to 1
" let g:pandoc#filetypes#pandoc_markdown = 0
" autocmd BufNewFile,BufRead *.md set filetype=markdown
" autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" normal mode mapings
" remove trailing spaces from file
nmap <leader>z :g/^$/d<cr>
" nmap <leader>s :%s/\s\+$//g<cr>
" toggle line numbers
nmap <leader>l :set nu! rnu! list!<cr> :CocCommand git.toggleGutters<cr> :ALEToggle<cr> :GitGutterBufferToggle<cr>
" toggle nerd tree
nmap <leader>n :NERDTreeToggle<cr>
"space separated to column
nmap <leader>c :s/\s\+/\r/g<cr>
nmap <leader>C :s/\s\+/\r/g<cr> :sort<cr>

" normal mode: edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc<cr>

" insertmode: jk is escape
inoremap jk <esc>

" normal mode
noremap  <f1> :colorscheme torte<cr>:set nu! rnu!<cr>:Sopen ghci<cr>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType vim              let b:comment_leader = '" '
"autocmd FileType make,snippets set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType make,snippets set noexpandtab shiftwidth=4 softtabstop=0

" fsharp file set based on .fs
autocmd BufNewFile,BufRead *.fs :set filetype=fsharp

" noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" :checkhealth
" python2 -m pip uninstall neovim pynvim
" python3 -m pip uninstall neovim pynvim
" python3 -m pip install --user --upgrade pynvim
" python2 -m pip install --user --upgrade pynvim
" https://github.com/neovim/neovim/blob/master/runtime/doc/provider.txt
"let g:loaded_python_provider = 0
"let g:loaded_python3_provider = 0
"let g:python3_host_prog = '/usr/bin/python3'
"let g:python2_host_prog = '/usr/bin/python2'
"let g:fsharp_interactive_bin = '/opt/dotnet/sdk/2.2.108/FSharp/fsi.exe'

" for rust
let g:rustfmt_autosave = 1

set exrc " allows loading local executing local rc files
set secure " disallows the use of :autocmd, shell and write commands

set cursorline
" override the cursor settings
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

set ffs=unix
set encoding=utf-8
set fileencoding=utf-8
"set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
set listchars=eol:¬,tab:»·,trail:␠,nbsp:⎵

"set listchars=eol:¬
"set listchars+=tab:».
"set listchars+=tab:->
set list

" center on motions
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz


" <leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

map <F2> :.w !pbcopy<cr><cr>
map <F3> :r !pbpaste<cr>

"let g:python_host_prog = '/full/path/to/neovim2/bin/python'
"let g:python3_host_prog = '/full/path/to/neovim3/bin/python'
"
" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" close a window
map <C-c> <C-w>c

" Shortcut split opening
nnoremap <leader>h :split<cr>
nnoremap <leader>v :vsplit<cr>
" nnoremap <leader>f :FloatermNew --height=0.5 --width=0.5 --position=left --wintype=normal lf<cr>
nnoremap <leader>f :FloatermNew lf<cr>

" autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
" autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

" enable spell check for markdown
" autocmd FileType markdown setlocal spell spelllang=en_us

" quit vim when 0 buffers left on nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" TODO: test the below
"Neovim terminal
if has('nvim')
  let g:python_host_skip_check = 0
  " let g:python_host_prog = 'python'
  let g:python3_host_skip_check = 0
  " let g:python3_host_prog = 'python3'

  "TODO: termguicolors is not good for urxvt
  " tput colors
  "set termguicolors
  tnoremap <C-q> <C-\><C-n>

  function! Term()
      :e term://zsh
  endfunction
  command! Term :call Term()
endif

function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

" Hex read
nmap <leader>hr :%!xxd<cr> :set filetype=xxd<cr>

" Hex write
nmap <leader>hw :%!xxd -r<cr> :set binary<cr> :set filetype=<cr>


" let g:vimwiki_list = [{'path': '~/documents/', 'syntax': 'markdown', 'ext': '.md'}]

" enable true colors only if available
let colorterm=$COLORTERM
if colorterm=='truecolor' || colorterm=='24bit'
  set termguicolors
  " also set escape characters for true colors, if needed
  if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

noremap <leader>u :w<Home>silent <End> !urlview<cr>

" highlight nonascii chars
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2


" gui settings
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

set guifont=monofur\ for\ Powerline:h18
" set guifont=Symbola:h10
" set guifont=FuraCode\ Nerd\ Font:h12
