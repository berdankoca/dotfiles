set number
syntax enable
set background=dark
" colorscheme cosmic_latte
set mouse=a

set tabstop=4
"set shiftwidth=4
"set expandtab

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
