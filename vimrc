" I hate spaces in end of lines or tabs anywhere
" match Error /\t\|\s\+$/

" convert tabs to spaces, use 4 spaces (in tab jump and shift)
set ts=4
set expandtab
set sw=4

" .tt and .tt2 are html files for me
au BufNewFile,BufRead *.tt set filetype=html
au BufNewFile,BufRead *.tt2 set filetype=html
au BufNewFile,BufRead *.t set filetype=perl
au BufNewFile,BufRead *.md set filetype=markdown

:ab p3rl #!/usr/bin/perluse strict;use warnings;

" experimental, darkred? FFD9D9?
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" original: /\%81v.*/
match OverLength /\%81v.\+/

" Makefiles work with tabs and not spaces
autocmd FileType make setlocal noexpandtab

" remaps to handle tmux stuff
" noremap [OD <C-Left>
" noremap! [OD <C-Left>
" noremap [OC <C-Right>
" noremap! [OC <C-Right>

" noremap [3~ gT

" set background=light
set background=dark
inoremap <F3> <c-o>:w<cr>

execute pathogen#infect()

"vnoremap <F2> PerlTidy()
"imap `` <esc>
"imap !! <ESC>:'<,'>!perl /home/sawyer/code/personal/p5p-summaries/bin/expand.pl<CR>a
"map <F2> :echo 'Current time is ' . strftime('%c')<CR>
map <F2> :!perl /home/sawyer/code/personal/p5p-summaries/bin/expand.pl<CR>
map <F3> :w !perl /home/sawyer/code/personal/p5p-summaries/bin/commit-review.pl<CR>
"imap !! <ESC>:'<,'>!perl /home/sawyer/code/personal/p5p-summaries/bin/expand.pl<CR>a

":perl use Carp::Always;
":perl push @INC, '/home/sawyer/code/personal/p5p-summaries/lib';
":perl use Vim::X::Plugin::P5PSummaries;
"imap !! <ESC>:call P5PExpand()<CR>a

"source ~/.vim/perltidy.vim
nnoremap <silent> tt :%!perltidy -q<Enter>
vnoremap <silent> tt :!perltidy -q<Enter>

