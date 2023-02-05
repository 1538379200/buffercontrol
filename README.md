# buffercontrol
Quickly manipulate vim's buffer

临时写的一个简单插件，进行buffer管理
## 安装
### Packer
```use {'1538379200/buffercontrol'}```

## 界面预览
![image](https://user-images.githubusercontent.com/42434762/216809339-feea75cd-2064-4233-bef6-2216a666b158.png)


## 默认快捷键
- ```<leader>b``` 打开悬浮管理窗口
- ```<Tab>/<Shift><Tab>``` 向下/向上移动，你也可以使用 ```j/k``` 移动
- ```o``` 或者 ```<Enter>``` 切换到光标下的buffer
- ```x``` 关闭光标下的buffer
- ```X``` 关闭除光标下的其他buffer
- ```q``` 或者 ```<Esc>``` 可退出悬浮窗口

## 命令行
- ```:BufferControl``` 打开悬浮窗口
- ```:Bdo``` 关闭除当前buffer外其他buffer


## 配置
插件不需要其他配置，不过你也可以改动一下
```vimscript
nmap <leader>b :BufferControl<cr>
nmap <leader>x :Bdo<cr>
```
