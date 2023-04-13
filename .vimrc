" =======================================================================================================================================

" .vimrc Vim Config created by Neph Iapalucci

" ===================================================================================================================================
" Options ---------- Options ---------- Options ---------- Options ----------  Options ---------- Options ---------- Options --------
" ===================================================================================================================================

" Here is where built-in Vim options are set to my liking.

set nocompatible " Make Stuff work

set autoindent " When creating a new line, keep the indent of the previous line
set incsearch " When searching within a file, show results as search term is typed
set fillchars=eob:\  " Remove tildes (~) at start of each line
set ffs=unix " Enable unix-style line-enders (\n instead of \r\n)
set notimeout ttimeout ttimeoutlen=200 " Disable inactive timing out for multi-key commands
set nowrap " Disable long lines wrapping over
set number " Enable line numbers
set relativenumber " Make line numbers relative to cursor position
set showbreak=+ " Being folded lines with a '+' to indicate that they are folded
set showcmd " Show key history when typing commands in normal mode
set t_vb= " Disable flashing when pressing invalid key
set tabstop=4 " Number of spaces per tab
set textwidth=5000 " Disable automatic line splitting for long lines
set visualbell " Enable built-in flash when pressing invalid key (must enable to disable)
set wildmenu " Enable command-line completion
set wildmode=longest,list " Set format of command-line help and completion

" ===================================================================================================================================
" Features ---------- Features ---------- Features ---------- Features ---------- Features ---------- Features ---------- Features --
" ===================================================================================================================================

filetype indent plugin on " Attempt to detect the language of a file by its contents/extension

" ===================================================================================================================================
" Mappings ---------- Mappings ---------- Mappings ---------- Mappings ---------- Mappings ---------- Mappings ---------- Mappings --
" ===================================================================================================================================

nnoremap <Tab> :bn<CR>| " Map <Tab> to switch between open buffers

" ===================================================================================================================================
" Plugins ---------- Plugins ---------- Plugins ---------- Plugins ---------- Plugins ---------- Plugins ---------- Plugins ---------
" ===================================================================================================================================

" Here is where plugins are installed using vim-plug.

call plug#begin() " Begin plugin installation

Plug 'dense-analysis/ale' " Linting & LSP Support
Plug 'gelguy/wilder.nvim' " Suggestions when typing commands
Plug 'joshdick/onedark.vim' " One Dark theme
Plug 'preservim/nerdtree' " File Tree
Plug 'ryanoasis/vim-devicons' " File tree icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Colored icons for file tree
Plug 'tpope/vim-fugitive' " Git Integration
Plug 'vim-airline/vim-airline' " Bottom Status Bar

call plug#end() " Finish plugin installation

" ===================================================================================================================================
" Plugin Config ---------- Plugin Config ---------- Plugin Config ---------- Plugin Config ---------- Plugin Config ---------- Plugin
" ===================================================================================================================================

" Here is where settings are configured for various plugins.

" dense-analysis/ale ----------------------------------------------------------------------------------------------------------------

let g:ale_linters = {'rust': ['rustc', 'rls']}

let g:ale_sign_error = '' " The error sign
let g:ale_sign_warning = '' " The warning sign

" gelguy/wilder.nvim -------------------------------------------------------------------------------------------------------------------------------

call wilder#setup({'modes': [':', '/', '?']}) " Enable wilder

" Set renderer to popup with dev icons
call wilder#set_option('renderer', wilder#popupmenu_renderer({
	\ 'highlighter': wilder#basic_highlighter(),
	\ 'left': [
	\	' ', wilder#popupmenu_devicons(),
	\ ],
	\ 'right': [
	\	' ', wilder#popupmenu_scrollbar(),
	\ ],
\ }))

" joshdick/onedark.vim ---------------------------------------------------------------------------------------------------------

" Enable true color
if (empty($TMUX))
	if(has("nvim"))
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	if (has("termguicolors"))
		set termguicolors
	endif
endif

" Turn on the theme
syntax on
colorscheme onedark

" perservim/nerdtree -------------------------------------------------------------------------------------------------------

let NERDTreeMinimalUI = 1 " Remove tips from file tree
let NERDTreeWinSize = 27 " Set width of file tree
let NERDTreeShowHidden = 1 " Show hidden files (beginning with '.')

" Automatically open file tree upon starting Vim (and put the cursor back into the main window)
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Automatically close file tree if no other windows are open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Hide slashes (/) after file names
augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end

" vim-airline/vim-airline ---------------------------------------------------------------------------------------------------------------------

let g:airline#extensions#tabline#fnamemod = ':t' " Show only file name in tabline (not path)
let g:airline_powerline_fonts=1 " Enable beveled status bar (instead of flat)

" Define the symbol map if it doesn't exist
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
if !exists('g:airline_mode_map') | let g:airline_mode_map = {} | endif

let g:airline#extensions#tabline#enabled=1 " Enable top bar tabs

let g:airline_symbols.linenr = ' Line: ' " Set line number text to 'Line: '
let g:airline_symbols.maxlinenr = '' " Remove character after line count
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%' , 'linenr', 'maxlinenr']) " Remove column number

" Set mode names to camel case
let g:airline_mode_map.n = 'Normal'
let g:airline_mode_map.i = 'Insert'
let g:airline_mode_map.R = 'Replace'
let g:airline_mode_map.v = 'Visual'
let g:airline_mode_map.c = 'Command'
