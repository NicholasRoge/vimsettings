runtime pathogens/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('pathogens/{}')
call pathogen#helptags()

" Needed for Airline plugin
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

syntax on

set background=dark
colorscheme material-theme

set tabstop=4 shiftwidth=4 expandtab
set nowrap
set number

" Courtesy of http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
if $EMULATOR == 'iTerm'
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    
    if exists('$TMUX')
        " Courtesy of http://vi.stackexchange.com/questions/3379/cursor-shape-under-vim-tmux
        let &t_EI = "\<Esc>Ptmux;\<Esc>".&t_EI."\<Esc>\\"
        let &t_SI = "\<Esc>Ptmux;\<Esc>".&t_SI."\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>".&t_SR."\<Esc>\\"
    endif
else
    " if filereadable("/etc/os-release")
    if has("autocmd")
        au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
        au InsertEnter,InsertChange *
            \ if v:insertmode == 'i' | 
            \   silent execute '!echo -ne "\e[6 q"' | redraw! |
            \ elseif v:insertmode == 'r' |
            \   silent execute '!echo -ne "\e[4 q"' | redraw! |
            \ endif
        au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
    endif 
endif
if $TERM =~ 'screen.'
    let &t_EI = "\<Esc>P".&t_EI."\<Esc>\\"
    let &t_SI = "\<Esc>P".&t_SI."\<Esc>\\"
    let &t_SR = "\<Esc>P".&t_SR."\<Esc>\\"
endif


" Allows undos across vim sessions.
if has('persistent_undo')
	silent !mkdir -p "$HOME/.vim/undodir"
	set undofile
	set undodir=~/.vim/undodir
endif

set directory=~/.vim/swapfiledir

" Needed 
filetype plugin on
filetype indent on

" Enable Mouse Support
set mouse=a

set backspace=indent,eol,start

let s:runtimepath = fnamemodify(expand("$MYVIMRC"), ":p:h")
execute "source ".s:runtimepath."/keymap.vim" 
