syntax on             " enable syntax highlightning
set cursorline        " highlight current line
set number            " show line numbers
set ruler             " show line numbers in bar
set background=dark   " color scheme for dark background
set nobackup          " don't create *.ext~ backup files - I'll use git instead
set autoread          " watch for file changes
set showmode          " show current VIM mode
set showmatch         " show matching brackets
set scrolloff=5       " show at least x lines above/below
filetype on           " enable filetype detection
filetype indent on    " enable filetype-specific indenting
filetype plugin on    " enable filetype-specific plugins


" tabs and indenting
set autoindent        " auto indenting
set smartindent       " smart indenting
set smarttab          " better backspace and tab functionality
set expandtab         " spaces instead of tabs
set tabstop=2         " x spaces for tabs
set shiftwidth=2      " x spaces for indentation

" search
set hlsearch          " highlighted search results

" bells
set visualbell        " turn off audio bell, but leave on a visual bell

" column-width visual indication
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=52 guibg=#5F0000

" share VIM clipboard with your OS
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" filetype specific options
au FileType gitcommit set tw=80
au BufRead,BufNewFile *.dockerfile set filetype=dockerfile
au BufRead,BufNewFile *.md setlocal tw=80
au BufRead,BufNewFile *.txt setlocal tw=80

" buffer size on copy/cut
set viminfo='20,<1000,s1000

" shortcut commands
map @@x ! xmllint --format -<CR>
map @@j ! jq '.'<CR>
map <F7> :tabp<CR>
map <F8> :tabn<CR>
