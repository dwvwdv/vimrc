function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map('n', shortcut, command)
end

function imap(shortcut, command)
	map('i', shortcut, command)
end

-- 檔案編碼一致
vim.o.encoding='utf-8'
vim.o.termencoding='utf-8'
vim.o.fileencoding='utf-8'

-- 基礎設定
vim.o.nu = true
vim.o.rnu = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.sidescroll=1

-- 縮排與tab鍵一致
vim.o.tabstop=4
vim.o.shiftwidth=4

-- 目錄自動切換
vim.o.autochdir = true

-- 括號補全
imap("(","()<Left>")
imap("[","[]<Left>")
--imap("<","<><Esc>i")
imap("{<CR>","{}<Left><CR><CR><Up><TAB>")
imap("\"","\"\"<Left>")
imap("'","''<Left>")

-- 取消查找與快速移動
nmap("<SPACE><CR>",":nohlsearch<CR>")
nmap("<SPACE>j","20jzz")
nmap("<SPACE>k","20kzz")

-- vimrc配置修改與載入
nmap("<F8>",":tabe<CR>:e $MYVIMRC<CR>")
nmap("<F9>",":tabe<CR>:e C:\\Users\\user\\vimfiles\\coc-config.vim<CR>")
nmap("R",":source $MYVIMRC<CR>")

-- 基礎鍵修改
nmap("s","<nop>")
nmap("t","<nop>")
nmap("S",":w<CR>")
nmap("Q",":q<CR>")

-- 視窗分割
nmap("sh",":vim.o.nosplitright<CR>:vsplit<CR>")
nmap("sl",":vim.o.splitright<CR>:vsplit<CR>")
nmap("sj",":vim.o.splitbelow<CR>:split<CR>")
nmap("sk",":vim.o.nosplitbelow<CR>:split<CR>")

-- 依賴於sh: sj sk sl映射的map
nmap("sd","sh:Ex<CR>:vertical resize -15<CR>")

-- 分頁切換
nmap("st",":tabe<CR>")
nmap("sp",":-tabnext<CR>")
nmap("sn",":+tabnext<CR>")

-- Buffer Switch
nmap("<A-j>",":bnext<CR>")
nmap("<A-k>",":bprevious<CR>")
nmap("<A-c>",":%bd\\|e#<CR>")

-- 自動縮排
nmap("!","gg=G``")

-- terminal與編譯
nmap("tl :vim.o.splitbelow<CR> :terminal","++rows=7<CR>")
nmap("<F5>",":call CompileRunGcc()<CR>")
nmap("<F6>",":!cls<CR><CR>:call SSHCompileRunGcc()<CR>")

vim.cmd([[
" 外部剪貼簿設定 
set clipboard=unnamed 
" backspace work 
set backspace=indent,eol,start
"進入點改為上次離開位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" 檔案判斷自動縮排與語法高亮
filetype indent on
syntax on
exec "nohlsearch"

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
		# exec "! python %"
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

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
so $HOME\vimfiles\plugConfig\coc-config.vim

Plug 'voldikss/vim-floaterm'
so $HOME\vimfiles\plugConfig\floatTerm-config.vim

Plug 'kdheepak/lazygit.nvim'
Plug 'preservim/nerdtree'
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'nordtheme/vim'

call plug#end()

colorscheme nord
so $HOME\vimfiles\plugConfig\toggle.vim
]])

nmap("tl",":FloatermNew<CR>")
nmap("<SPACE>gg",":LazyGit<CR>")
nmap("sd",":NERDTreeToggle<CR>")
nmap("<SPACE>m","<Plug>MarkdownPreview")

