function! s:ReadPipe(command)
    enew

    python << EOF
import subprocess
import vim

target = vim.current.buffer
command = vim.eval("a:command")
process = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
for line in iter(process.stdout.readline, ""):
    target.append(line)
    vim.command("redraw") 
EOF
endfunction

command! -nargs=* ReadPipe call s:ReadPipe('<args>')
