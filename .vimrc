" vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'

" jedi-vim
let g:jedi#completions_command = "<C-Space>"

" NerdTree
map <F2> :NERDTreeToggle<CR>

" The bundles you install will be listed here
filetype plugin indent on

" The rest of your config follows here

" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

"====phpcomplete-extended start
"autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
"====phpcomplete-extended end

syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8

"au BufEnter *.php set ai sw=2 ts=2 sta et fo=croql nu

au BufRead,BufNewFile *.tpl set filetype=smarty
au Filetype smarty exec('set dictionary=/home/ferry/.vim/syntax/smarty.vim')
au Filetype smarty set complete+=k

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufNewFile,BufReadPre /* call LoadCscope()
"cscope settings
if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   elseif filereadable("../cscope.out")
      cs add ../cscope.out ..
   elseif filereadable("../../cscope.out")
      cs add ../../cscope.out ../..
   elseif filereadable("../../../cscope.out")
      cs add ../../../cscope.out ../../..
   elseif filereadable("../../../../cscope.out")
      cs add ../../../../cscope.out ../../../..
   elseif filereadable("../../../../../cscope.out")
      cs add ../../../../../cscope.out ../../../../..
   elseif filereadable("../../../../../../cscope.out")
      cs add ../../../../../../cscope.out ../../../../..
   endif
   set csverb
endif

" Using 'CTRL-backslash' then a search type makes the vim window
" split horizontally, with search result displayed in the new window.

nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>

autocmd FileType html,css,xml,ant set smartindent|set tabstop=2|set shiftwidth=2|set expandtab|set nu
autocmd FileType c,cpp,javascript,php,java set smartindent|set tabstop=4|set shiftwidth=4|set expandtab|set nu

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=/home/ferry/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/ferry/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'davidhalter/jedi-vim'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Highlight execess line length
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 200
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%200v.*/
    autocmd FileType python set nowrap
    augroup END
