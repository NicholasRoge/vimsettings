runtime pathogens/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('pathogens/{}')

" Needed for Airline plugin
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

syntax on
set background=dark
colorscheme material-theme

set tabstop=4 shiftwidth=4 expandtab
set nowrap
set number

" Courtesy of http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
if filereadable("/etc/os-release")
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
else 
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
endif 

" Allows undos across vim sessions.
if has('persistent_undo')
	silent !mkdir -p "$HOME/.vim/undodir"
	set undofile
	set undodir=~/.vim/undodir
endif

set directory=~/.vim/swapfiledir
	

" Keybinds
nnoremap <silent> <F9> :TagbarToggle<CR>

" Needed 
filetype plugin on
filetype indent on
