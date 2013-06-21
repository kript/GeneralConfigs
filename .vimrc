"use \" for comments
"get vim to laod templates from this skeleton file area
"  where extentions are defined
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
setlocal fo+=aw
"only do spell checking in mutt emails however!
autocmd FileType mail set spell
