mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark.vim > ~/.vim/colors/atom-dark.vim
printf "syntax on\ncolorscheme atom-dark" > ~/.vimrc 
