" 设置缩进为4个空格
set tabstop=4        " 设置Tab键宽度
set softtabstop=4    " 设置空格的数量
set shiftwidth=4     " 设置缩进宽度
set expandtab        " 将Tab键转换为空格

" 自动缩进
set autoindent       " 自动缩进
set smartindent      " 智能缩进

" 高亮搜索结果
set hlsearch         " 高亮搜索结果
set incsearch        " 实时显示匹配结果
set ignorecase       " 搜索时忽略大小写
set smartcase        " 大写字母时区分大小写

" 显示行号和状态
set number           " 显示行号
set cursorline       " 高亮当前行
set ruler            " 显示行列号

" 配置括号匹配
set showmatch        " 显示匹配的括号

" 显示状态栏
set laststatus=2     " 始终显示状态栏
set statusline=%<%F[%1*%M%*%n%R%H]%=%y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

" 启用鼠标支持
set mouse=a          " 启用鼠标支持
set mousemodel=popup
set selection=exclusive
set selectmode=mouse,key
set mousefocus       " 鼠标聚焦功能
set mousehide        " 隐藏鼠标光标

" 其他设置
set backupcopy=yes   " 备份文件时保留原文件的时间戳
set noerrorbells     " 关闭错误提示音
set novisualbell     " 关闭可视化提示音
set t_vb=            " 关闭可视化提示符
set magic            " 启用魔术模式
set hidden           " 允许在后台编辑多个文件

" 文件编码设置
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set term=xterm-256color
set termencoding=utf-8

" 配色方案
colorscheme elflord

" 自动检测缩进
filetype plugin indent on

" 其他优化设置
set paste            " 设置粘贴模式
set wrap             " 启用自动换行
set linebreak        " 换行时不在单词中间断行
set breakindent      " 换行后自动缩进
set formatoptions-=cro

" 自动保存文件（每次离开插入模式时保存文件）
autocmd InsertLeave * :w

" 自动文件头
" 添加文件头
function! AddTitle()
    if expand('%:e') == 'sh'
        let lines = [
            \ "#!/bin/bash",
            \ "#",
            \ "#********************************************************",
            \ "#author(作者):         Archangel",
            \ "#version(版本):        " . strftime("%Y-%m-%d"),
            \ "#date(时间):           " . strftime("%c"),
            \ "#FileName(文件名):     " . expand("%"),
            \ "#description(描述):    ",
            \ "#********************************************************",
            \ "#-----------------------------------------------------------------------------------",
            \ "",
            \ "",
            \ "#------------------------------- Environment Variable ------------------------------",
            \ "",
            \ "",
            \ "#------------------------------- Function Definetions ------------------------------",
            \ "",
            \ "",
            \ "#---------------------------------- Shell Main Body --------------------------------",
            \ "",
        ]
        call setline(1, lines)
    endif
endfunction

" 更新文件头
function! UpdateTitle()
    execute '/date(时间)/s@:.*$@=' . strftime(":%Y-%m-%d %H:%M") . '@'
    execute '/#FileName(文件名)/s@:.*$@=":" . expand("%:t")@'
    echohl WarningMsg | echo "Successfully updated the copyright." | echohl None
endfunction

" 检查文件头是否存在，不存在则添加
function! TitleDet()
    let found = 0
    for i in range(1, 10)
        let line = getline(i)
        if line =~ '^#\s*Last\s*modified\s*.*$'
            call UpdateTitle()
            let found = 1
            break
        endif
    endfor

    if !found
        call AddTitle()
    endif
endfunction