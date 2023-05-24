func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 --cmd="!gcc % -o %<"
	elseif &filetype == 'cpp'
		:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 --cmd="! g++ % -o %< && %<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		:FloatermNew --height=0.6 --width=0.4 --wintype=float --position=bottomright --autoclose=0 --cmd="python %"
	elseif &filetype == 'html'
		exec "! chrome % &"
	endif
endfunc


