" change color mode
set termguicolors

" set color scheme
colorscheme slate
hi NonText guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE

" turns on line numbering
set number

" turn on auto indent
set autoindent
filetype plugin indent on

" remap fold toggle to space
nnoremap <space> za

" set tabs to 4 cols
set tabstop=4
set shiftwidth=4
set softtabstop=4

highlight Folded ctermfg=BLACK guifg=Cyan
highlight Folded ctermbg=NONE guibg=NONE

function! MyFoldText()
	let nblines = v:foldend - v:foldstart + 1
	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let line = getline(v:foldstart)
	let comment = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
	let expansionString = repeat(".", w - strwidth(nblines.comment.'"'))
	let txt = '"' . comment . expansionString . nblines
		return txt
	endfunction
	set foldtext=MyFoldText()

augroup remeber_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

" command to auto install vim plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubussercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	Plug 'mg979/vim-visual-multi', {'branch':'master'}
	Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" green/red diffs
highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

map <F4> :sp %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
