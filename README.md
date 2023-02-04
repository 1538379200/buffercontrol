# buffercontrol
Quickly manipulate vim's buffer

临时写的一个简单插件，进行buffer管理
## 安装
### Packer
```use {'1538379200/buffercontrol'}```

## 使用
- ```<leader>b``` 打开buffer管理悬浮窗口
- 悬浮窗口中，```x``` 可关闭当前光标下的buffer
- 悬浮窗口中，```<C-x>``` 可关闭除当前光标下的其他buffer
- 悬浮窗口中，```<Enter>``` 可打开光标下的buffer
- 悬浮窗口中，```q``` 或者 ```<Esc>``` 可退出当前窗口
- 使用命令 ```:Bdo``` 可关闭其他buffer
![image](https://user-images.githubusercontent.com/42434762/216771087-cb27388d-b397-46fd-b84d-a1e0723200c7.png)

