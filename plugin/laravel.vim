function! laravel#IsSitePath(path)
	return !empty(laravel#SitePath(a:path))
endfunction

function! laravel#SiteRoot(path)
	" Strip the file or traling directory slash from path.  Absolute paths
	" returned from fnamemodify will always take the form of /**/ if a:path
	" is a directory or /**/* if a:path is a file.
	let path = fnamemodify(a:path, ':p')
	let path = split(path, "/", 1)[0:-2]

	" Traverse up the directory tree looking for the 'artisan' file.  A tell
	" tale sign that we're in a laravel application directory.
	while len(path) > 0
		let site_root = join(path, "/")

		if filereadable(site_root."/artisan")
			return site_root
		endif

		let path = path[0:-2]
	endwhile

	return ""
endfunction

function! laravel#Exec(script)
	" Yes I am aware this is a huge security vulerability
	" Yes I am looking for a better solution
	let script = substitute(a:script, "'", "\"'\"", "")
	let output = system("php '".s:repo_path."/artisan' tinker <<< '".script."'")


	let results = []
	for line in split(output, "\n", 1)[1:-4]
		if line =~ "^=>"
			continue
		endif

		echom line

		" add(results, substitute(line, '⏎$', '', ''));
	endfor
	return join(results, "\n")
endfunction

function! laravel#EditView(name) 
	" echom s:LaravelExecute("try { echo view('".name."')->getPath(); } catch (\Throwable $t) { }")
	exec "edit ".s:repo_path."/resources/views/".substitute(a:name, ".", "/", "") 
endfunction

function! laravel#CompleteView(current, full, cursor_pos)
	return glob(s:repo_path."/resources/views/".substitute(a:current, ".", "/", "")."*")
endfunction


function! laravel#GoView()
	if !laravel#IsSitePath(expand("%"))
		echoerr "File is not inside of a laravel application."
	endif


	let current_line = getline(".")
	
	let start_offset = col(".") - 1
	let length = 1


	let view_name_regex = "[a-zA-Z0-9._]+"
	while current_line[start_offset:length] =~ view_name_regex
		--start_offset
		++length
	endwhile 
	while current_line[start_offset:length] =~ view_name_regex
		++length
	endwhile 

	laravel#EditView(current_line[start_offset:length])
endfunction	
	
	

nmap gv :call laravel#GoView()<CR>

" command -nargs=1 -complete=customlist,s:LaravelCompleteView EditView call s:LaravelEditView(<f-args>)
