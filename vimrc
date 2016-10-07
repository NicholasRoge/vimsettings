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

set tabstop=4 shiftwidth=4 noexpandtab
set number

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Allows undos across vim sessions.
if has('persistent_undo')
	silent !mkdir -p "$HOME/.vim/undodir"
	set undofile
	set undodir=~/.vim/undodir
endif

	

" Keybinds
nnoremap <silent> <F9> :TagbarToggle<CR>
