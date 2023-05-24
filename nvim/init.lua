
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
-- vim.o.cmdheight=0

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
nmap("R",":Lazy<CR>")

-- 基礎鍵修改
nmap("s","<nop>")
nmap("t","<nop>")
nmap("S",":w<CR>")
nmap("Q",":q<CR>")

-- 視窗分割
nmap("sh",":set nosplitright<CR>:vsplit<CR>")
nmap("sl",":set splitright<CR>:vsplit<CR>")
nmap("sj",":set splitbelow<CR>:split<CR>")
nmap("sk",":set nosplitbelow<CR>:split<CR>")

-- 依賴於sh: sj sk sl映射的map
nmap("sd","sh:Ex<CR>:vertical resize -15<CR>")

-- 分頁切換
nmap("st",":tabe<CR>")
nmap("sp",":-tabnext<CR>")
nmap("sn",":+tabnext<CR>")

-- Buffer Switch
nmap("<A-j>",":bnext<CR>")
nmap("<A-k>",":bprevious<CR>")
nmap("<A-h>",":bfirst<CR>")
nmap("<A-l>",":blast<CR>")
nmap("<A-c>",":%bd|e#<CR>")

-- Pin Buffer
nmap("tt",":tabm 0<CR>")

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
let g:python3_host_prog = 'C:\Users\user\AppData\Local\Programs\Python\Python311\python'

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

"so $HOME\vimfiles\plugConfig\toggle.vim
]])

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({{import = "plugins"}})

require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil , -- use a custom function for sorting files and directories in the tree 
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖",-- this can only be used in the git_status source
              renamed   = "",-- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-global-custom-commands`
        commands = {},
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = { 
                "toggle_node", 
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = { 
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = false, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
            },
          },

          commands = {} -- Add a custom command or override a global one using the same function name
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        }
      })

vim.cmd([[
	color nord
	so C:\Users\user\AppData\Local\nvim\config\coc-config.vim
	so C:\Users\user\AppData\Local\nvim\config\floatTerm-config.vim
]])


nmap("tl",":FloatermNew<CR>")
nmap("<SPACE>gg",":LazyGit<CR>")
nmap("sd",":Neotree position=right<CR>")
nmap("<SPACE>m","<Plug>MarkdownPreview")
