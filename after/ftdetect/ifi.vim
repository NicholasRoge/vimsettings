let s:ifi_repo_origin = "^git@git\.innovationfirst\.net:.*$"

function s:TrySetFiletype()
	let path = expand("%")
	if isdirectory(path)
		return
	else
		let path = fnamemodify(path, ":h")
	endif

	let repo_origin = substitute(system("git -C '".path."' config --get remote.origin.url"), "\n", "", "")
	if repo_origin !~? s:ifi_repo_origin
		return
	endif

	if exists('&filetype')
		let &filetype .= ".ifi"
	else
		let &filetype = "ifi"
	endif
endfunction

autocmd BufNewFile,BufRead * call s:TrySetFiletype()
