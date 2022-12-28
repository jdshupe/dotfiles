" change color mode
set termguicolors

" set color scheme
colorscheme slate

" turn on line numbering
set number

" turn on auto indent
set autoindent
filetype plugin indent on

" set tabs to 4 cols
set tabstop=4
set shiftwidth=4
set softtabstop=4

" custom folding settings
" remap to space
nnoremap <space> za
" fold function
set foldmethod=manual
function! MyFoldText()
	let indent_level = indent(v:foldstart)
	let indent = repeat('    ',indent_level)
	let nblines = v:foldend - v:foldstart + 1
	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let line = getline(v:foldstart)
	let comment = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
	let expansionString = repeat(".", w - strwidth(nblines.comment.'"'))
	let txt = indent . comment . expansionString . nblines
		return txt
	endfunction
	set foldtext=MyFoldText()
" remember folds
augroup remeber_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END
" change colors
highlight Folded ctermfg=BLACK guifg=Cyan
highlight Folded ctermbg=NONE guibg=NONE

set nocompatible
filetype off

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" word wrapping
set fo+=t
set fo-=l
set textwidth=80

" add sql mapping
vmap R <esc>:'<,'> !sqlite3 --markdown ~/vimwiki/wiki.db <enter><\>
vmap T <esc>:'<,'> !sqlite3 --table ~/vimwiki/wiki.db <enter><\>

" add map for lat long
" this one replaces inline selected text in visual mode
vmap F <esc>`<<Left>ma`><Right>mb`bi<CR><esc>`ai<CR><esc><S-V><esc>:'<,'>!~/vimwiki/geocode.sh<CR><Up><S-J><S-J><esc>
" this one replaces the whole line
vmap <c-f> <esc>:'<,'>!~/vimwiki/geocode.sh<CR>
" this one replaces inline selected text in select mode
smap <F2> <esc>`<<Left>ma`><Right>mb`bi<CR><esc>`ai<CR><esc><S-V><esc>:'<,'>!~/vimwiki/geocode.sh<CR><Up><S-J><S-J><esc>

" F4 now opens header file
map <F4> :sp %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"""""""""""""""""""""""""""""""""""""""""""
"               PLUGINS                   
"""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'SirVer/ultisnips'
	Plugin 'vimwiki/vimwiki'
	Plugin 'christoomey/vim-tmux-navigator'
	Plugin 'jdshupe/calendar.vim'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'luizribeiro/vim-cooklang', { 'for' : 'cook' }
call vundle#end()
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""
"             PLUGIN SETTING              
"""""""""""""""""""""""""""""""""""""""""""
" calendar.vim settings
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
source ~/.cache/calendar.vim/credentials.vim
let g:calendar_first_day = 'sunday'

" VIMWIKI settings
let g:vimwiki_table_mappings = 0
let g:vimwiki_use_calendar = 1
nmap <Leader>rb :VimwikiRebuildTags!<CR><bar>:VimwikiGenerateTagLinks<CR><bar>:VimwikiTOC<CR>


let work_wiki = {}
let work_wiki.name = 'Work Wiki'
let work_wiki.path = '~/vimwiki/'
let work_wiki.path_html = '/mnt/c/Users/JShupe/Desktop/wikihtml/'

let personal_wiki = {}
let personal_wiki.name = 'Personal Wiki'

let test_wiki = {}
let test_wiki.name = 'test wiki'
let test_wiki.path = '/mnt/c/Users/JShupe/Desktop/testingWiki'

let g:vimwiki_list = [work_wiki, test_wiki]

hi VimwikiHeader2 guifg=#fb8500
hi VimwikiHeader3 guifg=#219ebc
hi VimwikiHeader4 guifg=#8ecae6

" ULTISNIPS Settings
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpforwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
imap <c-u> <esc>:call UltiSnips#ListSnippets()<CR>

let g:UltiSnipsEditSplit = "vertical"

" VIMGUTTER Settings
highlight SignColumn guibg=NONE ctermbg=NONE
highlight GitGutterAdd guibg=NONE ctermbg=NONE
highlight GitGutterChange guibg=NONE ctermbg=NONE
highlight GitGutterDelete guibg=NONE ctermbg=NONE

" KEET AT BOTTOM make background transparent
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
set fillchars=vert:\ ,fold:-
