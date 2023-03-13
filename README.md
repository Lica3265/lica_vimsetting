# 我的Vim設定檔


## 我的設定檔

主要是從高老師那邊複製下來格式後，再依照自己喜歡的方式調整
來源：https://github.com/kaochenlong/cch

如果你喜歡我的 Vim 設定的話，可以使用以下方式進行安裝：

### 方法一：手動安裝

先備份原本的 `.vimrc`、`.gvimrc` 以及 `.vim` 目錄，然後進行以下程序：

    $ cd ~
    $ git clone https://github.com/Lica3265/lica_vimsetting.git .vim
    $ ln -s .vim/vimrc .vimrc
    $ ln -s .vim/gvimrc .gvimrc

最後開啟 Vim，並執行 `:PlugInstall` 指令安裝外掛程式。

