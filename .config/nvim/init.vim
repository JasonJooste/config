" Adapt to filetype. Required for NERD commenter
filetype plugin on
call plug#begin()
" The default plugin directory is '~/.vim/plugged'
" Leap
Plug 'ggandor/leap.nvim'
" Improve commenting
Plug 'preservim/nerdcommenter'
" Airline status bar for a bit more info
Plug 'vim-airline/vim-airline'
" Git integration
Plug 'tpope/vim-fugitive'
" Coc for npm plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" jiangmiao/auto-pairs - could be interesting later for bracket pairs
" For auto-generating python docstrings
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
" For nextflow syntax highlighting
Plug 'lukegoodsell/nextflow-vim'
" For liquid syntax highlighting
Plug 'tpope/vim-liquid'
call plug#end()	
" Coc bindings
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Leap remapping of s S and gs
lua require('leap').create_default_mappings()
autocmd FileType markdown,text setlocal spell spelllang=en_au
