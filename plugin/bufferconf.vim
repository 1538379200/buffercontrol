" 悬浮进行buffer管理
" 使用绑定按键 <leader>b 打开悬浮窗口
" 打开快捷键需要自定绑定 nmap <leader>b bufferconf#BufferControl()<cr>
" 使用 q 退出悬浮窗
" 使用 x 关闭当前光标所在buffer
" 使用 <C-x> 关闭除当前光标的其他所有buffer
" 使用命令行 :Bdo 不打开悬浮窗直接关闭其他buffer
" 命令行需要自行绑定 command! Bdo :call bufferconf#CloseOtherBuffer(1)
function! GetAllBuffers()
let buffers = execute("ls")
let buf_list = split(buffers, '\n')
let format_buffers = []
for buf in buf_list
    " call add(format_buffers, trim(buf))
    let msg_list = split(buf)
    let buf_num = ' ' . msg_list[0]
    while strlen(buf_num) < 5
        let buf_num = buf_num . ' '
    endwhile
    let buf_status = msg_list[1]
    while strlen(buf_status) < 5
        let buf_status = buf_status . ' '
    endwhile
    let buf_path = "" . ' ' . split(msg_list[2], "\"")[0]
    let buf_line = msg_list[4]
    let msg = buf_num . buf_status . buf_path . ':' . buf_line
    call add(format_buffers, msg)
endfor
return format_buffers
endfunction

function! GetBufferNumber()
    let line_text = getline(".")
    echo line_text
    return split(line_text)[0]
endfunction

function! SwitchBuffer()
    let buf_number = GetBufferNumber()
    call nvim_win_close(0, v:true) 
    execute("b" . buf_number)
endfunction

function! CloseBuffer()
    let buf_number = GetBufferNumber()
    execute("bd" . buf_number)
    call PutMsgInBuffer(0)
endfunction

function! bufferconf#CloseOtherBuffer(...)
    if a:0 == 0
        let buf_number = GetBufferNumber()
    else
        let buf_number = bufnr("%")
    endif
    let all_buffers = GetAllBuffers()
    for msg in all_buffers
        let other_number = split(msg)[0]
        if other_number != buf_number
            execute("bd" . other_number)
            " call PutMsgInBuffer(0)
        endif
    endfor
    if a:0 == 0
        call PutMsgInBuffer(0)
    endif
endfunction

function! PutMsgInBuffer(buf)
    let buffers_msg = GetAllBuffers()
    call nvim_buf_set_lines(a:buf, 0, -1, v:true, buffers_msg)
endfunction

function! bufferconf#BufferControl()
    let buf = nvim_create_buf(v:false, v:true)
    call PutMsgInBuffer(buf)
    let float_width = winwidth("%") / 3
    let float_height = winheight("%")
    let float_row = 0
    let float_col = 0
    let opts = {
        \"relative": "editor", 
        \"width": float_width, 
        \"height": float_height, 
        \"col": float_col, 
        \"row": float_row, 
        \"anchor": "NW", 
        \"border": "rounded", 
        \"style": "minimal"}
    let win = nvim_open_win(buf, v:true, opts)
    hi def BufferControlNormal ctermbg=LightBlue guibg=#284566 ctermfg=White guifg=White
    " call nvim_win_set_option(win, "winhl", "Normal:BufferControlNormal")
    " call nvim_win_set_option(win, "winhl", "Normal:")   
    call nvim_win_set_option(win, "winhl", "CursorLine:BufferControlNormal")
    call nvim_win_set_option(win, 'wrap', v:false)
    call nvim_win_set_option(win, 'cul', v:true)
    call nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    call nvim_buf_set_option(buf, 'buflisted', v:false)
    call nvim_buf_set_option(buf, 'buftype', 'nofile')
    call nvim_buf_set_keymap(buf, 'n', 'q', ':q<cr>', {'nowait': v:true, 'silent': v:true})
    call nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<cr>', {'nowait': v:true, 'silent': v:true})
    call nvim_buf_set_keymap(buf, 'n', '<Enter>', ':call SwitchBuffer()<cr>', {'silent': v:true, 'nowait': v:true})
    call nvim_buf_set_keymap(buf, 'n', 'o', ':call SwitchBuffer()<cr>', {'silent': v:true, 'nowait': v:true})
    call nvim_buf_set_keymap(buf, 'n', 'x', ':call CloseBuffer()<cr>', {'nowait': v:true, 'silent': v:true})
    call nvim_buf_set_keymap(buf, 'n', '<Tab>', 'j', {'nowait': v:true, 'silent': v:true})
    call nvim_buf_set_keymap(buf, 'n', '<S-Tab>', 'k', {'nowait': v:true, 'silent': v:true})
    call nvim_buf_set_keymap(buf, 'n', 'X', ':call bufferconf#CloseOtherBuffer()<cr>', {'nowait': v:true, 'silent': v:true})
    let no_keys = ['i', 'a', 'A', 'I', 'O', '<Insert>', '<Delete>', 'h', 'l', '<Left>', '<Right>', 'v', 'V', 'Q']
    for key in no_keys
        call nvim_buf_set_keymap(buf, 'n', key, "<Nop>", {})
    endfor
endfunction

command! Bdo :call bufferconf#CloseOtherBuffer(1)
command! BufferControl :call bufferconf#BufferControl()
nmap <leader>b :call bufferconf#BufferControl()<cr>
" command! Bdo :call CloseOtherBuffer(1)
" nmap <leader>b :call BufferControl()<cr>
