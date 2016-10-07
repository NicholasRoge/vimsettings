let s:repo_path = ""
let s:repo_origin = "git@git.innovationfirst.net:robotevents/robotevents.git"



function! s:IsOnRepoPath(path)
	if s:repo_path == ""
		if isdirectory(a:path)
			let path = a:path
		else
			let path = join(split(a:path, "/", 1)[0:-2], "/")
		endif

		let repo_origin = substitute(system("git -C '".path."' config --get remote.origin.url"), "\n", "", "")
		if repo_origin != s:repo_origin
			return 0
		endif

		let s:repo_path = substitute(system("git -C '".path."' rev-parse --show-toplevel"), "\n", "", "") 
	endif

	return a:path =~ "^".s:repo_path
endfunction

function! s:UpdateSettings()
	if !s:IsOnRepoPath(expand('%:p'))
		return
	endif


	exec "lcd ".s:repo_path

	" NERDTree

	setlocal tabstop=4 shiftwidth=4 noexpandtab
	setlocal number

	" Blade Stuff
endfunction 

augroup RobotEvents
	autocmd!
	autocmd BufNew,BufReadPost * :call s:UpdateSettings()
augroup end		
