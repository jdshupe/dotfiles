" change color mode
set termguicolors

" set color scheme
colorscheme slate

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

highlight Folded ctermfg=Black
highlight Folded ctermbg=DarkGrey

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

call plug#begin('~/.vim/plugged')
	Plug 'mg979/vim-visual-multi', {'branch':'master'}
call plug#end()
