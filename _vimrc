set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set nu
set cursorline
set wrap
set showcmd
set wildmenu
set hlsearch
exec "nohlsearch"
set incsearch
let mapleader = " "

syntax on
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

inoremap ( ()<Left>
inoremap [ []<Left>
"inoremap < <><Esc>i
inoremap { {}<Left><CR><CR><Up><TAB>
inoremap " ""<Left>
inoremap ' ''<Left>

"外部剪貼簿設定
set clipboard=unnamed 
"backspace work
set backspace=indent,eol,start

noremap <LEADER><CR> :nohlsearch<CR>
noremap <LEADER>j 25jz<CR>
noremap <LEADER>k 25kz<CR>

map <F8> :e $MYVIMRC<CR>
map R :source $MYVIMRC<CR>
map s <nop>
map S :w<CR>
map Q :q<CR>

map sh :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>

map st :tabe<CR>
map sp :-tabnext<CR>
map sn :+tabnext<CR>



map <F6> :!cls<CR><CR>
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
    elseif &filetype == 'cpp'
        exec "! g++ % -o %< && %<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "! python %"
    elseif &filetype == 'html'
        exec "! chrome % &"
    endif
endfunc

let g:isNu = 1

function! Change_nu()
   if g:isNu == 1
      let g:isNu += 1
      set rnu
   else
      set nornu
      let g:isNu -= 1
   endif
endfunction

map <LEADER>n :call Change_nu()<CR>

map g<LEADER> 2g;a


