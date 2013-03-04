"----------------------------------------------------------
"ステータスライン
"----------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L(%P)%m
"----------------------------------------------------------
"基本設定
"----------------------------------------------------------
set autoread                   " 他で書き換えられたら自動で読み直す
"set backup
"set backupdir=~/Dropbox/bak
set noswapfile                 " スワップファイル作らない
set hidden                     " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set vb t_vb=                   " ビープをならさない
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set showcmd					" コマンドをステータス行に表示
"----------------------------------------------------------
"表示
"----------------------------------------------------------
"タブの画面上での幅
set tabstop=4
" タブをスペースに展開(expandtab:展開する) 
set expandtab
"
set softtabstop=4
"
set shiftwidth=4
"
au BufNewFile,BufRead *.js  set nowrap tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.css set nowrap tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.tpl set nowrap tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.inc set nowrap tabstop=4 shiftwidth=4 softtabstop=4

set list
set lcs=tab:>.
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/
" 保存時に行末の空白を除去する
"autocmd BufWritePre * :%s/\s\+$//ge
set showmatch		 " 括弧の対応をハイライト
set showcmd		   " 入力中のコマンドを表示
set number			" 行番号表示
"---------------------------------------------------------
" 補完・履歴
"----------------------------------------------------------
set wildmenu		   " コマンド補完を強化
set wildchar=<tab>	 " コマンド補完を開始するキー
set wildmode=list:full " リスト表示，最長マッチ
set history=1000	   " コマンド・検索パターンの履歴数
set complete+=k		" 補完に辞書ファイル追加
"-------------------------------------------------------------------------------
" 検索設定
"----------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"---------------------------------------------------------
"その他
"----------------------------------------------------------
" 自動的にインデントする (noautoindent:インデントしない) 
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない) 
set wrapscan
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1    " ぶら下り可能幅
" コマンドをステータス行に表示
set showcmd
"esc連打で検索ハイライトを消す
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"-------------------------------------------------------------------------------
" キーバインド関係
"-------------------------------------------------------------------------------
" 行単位で移動(1行が長い場合に便利)
nnoremap j gj
nnoremap k gk
" バッファ周り
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>
nmap <silent> ,l    :BufExplorer<CR>
" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap G Gzz
nmap ,ee :e ++enc=euc-jp<CR>
imap <c-c> <esc>
"無名レジスタに入るデータを、*レジスタにも入れる。
:set clipboard+=unnamed
"ビジュアルモードの選択テキストをクリップボードに
:set clipboard+=autoselect

:syntax on

source $VIMRUNTIME/macros/matchit.vim

""" Unite.vim
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

" インサート／ノーマルどちらからでも呼び出せるようにキーマップ
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
" 単語単位からパス単位で削除するように変更
imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
" ESCキーを2回押すと終了する
nmap <silent><buffer> <ESC><ESC> q
imap <silent><buffer> <ESC><ESC> <ESC>q
nmap <silent><buffer> <C-g> q
imap <silent><buffer> <C-g> <ESC>q
endfunction

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

