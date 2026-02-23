" ~/.vimrc

"显示行号
set number
"显示相对行号
set relativenumber

"高亮当前行
set cursorline
"鼠标控制光标定位
set mouse=a
"语法高亮
syntax on

"使用空格替代TAB
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"自动缩进
set autoindent

"实时高亮匹配项（增量搜索）
set incsearch
"高亮显示所有搜索结果
set hlsearch
"搜索时忽略大小写
set ignorecase
"如果搜索词中包含了大写字母，则自动切换为大小写敏感搜索
set smartcase

"开启持久化撤销（undo），即使关闭再打开文件，也能撤销之前的更改
set undofile
"undo目录
silent !mkdir -p ~/.cache/vim/undo
set undodir=~/.cache/vim/undo

"与系统剪贴板同步，需要安装gvim
set clipboard=unnamedplus

