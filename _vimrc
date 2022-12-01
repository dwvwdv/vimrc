" 檔案編碼一致
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" 基礎設定
set nu
set rnu
set cursorline
set wrap
set showcmd
set wildmenu
set hlsearch
exec "nohlsearch"
set incsearch
let mapleader = " "

" theme
colorscheme desert
"set background=dark

" 縮排與tab鍵一致
set tabstop=4
set shiftwidth=4

" 檔案判斷自動縮排與語法高亮
filetype indent on
syntax on

" 進入點改為上次離開位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 目錄自動切換
set autochdir

" 括號補全
inoremap ( ()<Left>
inoremap [ []<Left>
"inoremap < <><Esc>i
inoremap {<CR> {}<Left><CR><CR><Up><TAB>
inoremap " ""<Left>
inoremap ' ''<Left>

" 外部剪貼簿設定 
set clipboard=unnamed 
" backspace work 
set backspace=indent,eol,start

" 取消查找與快速移動
noremap <LEADER><CR> :nohlsearch<CR>
noremap <LEADER>j 20jzz
noremap <LEADER>k 20kzz

" vimrc配置修改與載入
noremap <F8> :tabe<CR>:e $MYVIMRC<CR>
noremap R :source $MYVIMRC<CR>

" 基礎鍵修改
noremap s <nop>
noremap S :w<CR>
noremap Q :q<CR>

" 視窗分割
noremap sh :set nosplitright<CR>:vsplit<CR>
noremap sl :set splitright<CR>:vsplit<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sk :set nosplitbelow<CR>:split<CR>

" 依賴於sh: sj sk sl映射的map
map sd sh:Ex<CR>:vertical resize -15<CR>

" 分頁切換
noremap st :tabe<CR>
noremap sp :-tabnext<CR>
noremap sn :+tabnext<CR>

" 自動縮排
noremap ! gg=G``


" terminal與編譯
noremap tl :set splitbelow<CR> :terminal ++rows=7<CR>
noremap <F5> :call CompileRunGcc()<CR>
noremap <F6> :!cls<CR><CR>:call SSHCompileRunGcc()<CR>

func! SSHCompileRunGcc()
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

func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
	elseif &filetype == 'cpp'
		exec "silent !start cmd.exe /C g++ % -o %< && %< & pause"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "silent !start cmd.exe /C python % & pause"
	elseif &filetype == 'html'
		exec "! chrome % &"
	endif
endfunc

map cppe i#include<iostream><CR><CR>using namespace std;<CR><CR>int main(<Right>{<CR>return 0;<Esc>O

noremap g<LEADER> 2g;a

