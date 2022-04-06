lua require('plugins')

colorscheme dracula

"显示行号"
set number

"隐藏顶部标签栏"
set showtabline=0

"设置字体"
set guifont=Consolas:h13
set guifontwide=Microsoft_YaHei:h13
hi Normal ctermfg=252 ctermbg=none

"开启语法高亮"
syntax on

"设置tab长度"
set tabstop=4
set shiftwidth=4

"文件编码"
set fenc=utf-8
set backspace=2

"高亮搜索项"
set hlsearch

"突出显示当前行"
"set cursorline
"突出显示当前列"
set cursorcolumn

"设置历史条数"
set history=1024

"NERDTree 过滤"
let NERDTreeIgnore=['\.pyc$']

"设置Python3路径"
let g:python3_host_prog = 'D:/Python39/python3'

noremap <silent> <C-S>          :update<CR>
