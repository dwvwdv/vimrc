"set encoding=utf-8
"set termencoding=utf-8
"set fileencoding=utf-8

set nu
set cursorline
set wrap
set showcmd
set wildmenu
set hlsearch
exec "nohlsearch"
set incsearch
let mapleader = " "

inoremap ( ()<Left>
inoremap [ []<Left>
"inoremap < <><Esc>i
inoremap { {}<Left><CR><CR><Up><TAB>
inoremap " ""<Left>
inoremap ' ''<Left>

"外部剪貼簿設定
set clipboard=unnamed 

noremap <LEADER><CR> :nohlsearch<CR>

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

map <LEADER><LEADER> :Goyo<CR>

map sd :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""

map <LEADER>c :Coc


map <F6> :!clear<CR><CR>
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
    elseif &filetype == 'cpp'
        exec "! g++ % -o %< && ./%<"
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

"Plug Install

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'



" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }

" Error checking
Plug 'w0rp/ale'

" Auto Complete
"Plug 'Valoric/YouCompleteMe'

" Undo Tree
Plug 'mbbill/undotree/'

" Other visual enhancement
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/vim-cursorword'

" Git
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'mattn/emmet-vim'

" Python
Plug 'vim-scripts/indentpython.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'

" Bookmarks
Plug 'kshenoy/vim-signature'

" Other useful utilities
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim' " distraction free writing mode
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'fadein/vim-FIGlet'


"coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/goyo.vim'


call plug#end()

"Plug
color koehler  



" 太長的更新間隔會導致明顯的延遲並降低使用者體驗（預設是 4000 ms = 4s ）
set updatetime=300

" 永遠顯示 signcolumn（行號左邊那個，這我不知道怎麼翻），否則每當有診斷出來時整個程式碼就會被往右移
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " 新的版本可以把 signcolumn 和行號合併（這個我版本不夠沒看過，有人知道會長怎樣可以下面留言嗎？）
  set signcolumn=number
else
  set signcolumn=yes
endif

" 用 tab 鍵觸發自動補全
" 注意：載入設定後記得用命令 `verbose imap <tab>` 確定這沒有被其他外掛覆蓋掉
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 讓 enter 鍵自動完成第一個建議並讓 coc 進行格式化（不確定個格式化指的是什麼，我看不太出來）
" enter 可以被重複 keymap（看不懂就算了，意思是你亂搞不會出錯）
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 用 \rn 重新命名變數、函數（原文寫「符號」）
nmap <leader>rn <Plug>(coc-rename)

" 這個讓你可以捲動浮動視窗和跳出式框框（有時候自動補全給你的文件會太長超出螢幕，如果你想要看下面的內容必須設定這個）
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

