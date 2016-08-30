" downloaded from https://raw.githubusercontent.com/nginx/nginx/37a3a2b2e8ef3202045e4095d894f806ed5e7654/contrib/vim/ftdetect/nginx.vim

au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
