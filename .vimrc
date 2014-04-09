"use \" for comments
"get vim to load templates from this skeleton file area
"  where extentions are defined
filetype plugin indent on
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
"enable syntax highlighting
syntax on
"enable line numbering
set nu
"set paper type to A4
set printoptions=paper:a4
"turn on automatic spell checking
":setlocal spell spelllang=en_gb
"text flowing for mutt emails
"  as per http://wcm1.web.rice.edu/mutt-tips.html
"setlocal fo+=aw
"only do spell checking in mutt emails however!
autocmd FileType mail set spell
autocmd FileType mail setlocal fo+=aw
" turn off autoindenting etc when pasing in 
set paste
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"highlight when going over 80 chars
match ErrorMsg '\%>80v.\+'
set colorcolumn=80
set textwidth=80
