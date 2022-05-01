# 我的Vim設定檔


## 我的設定檔

目前它看起來是這個樣子（使用配色 Gruvbox）：

![screenshot]()

如果你喜歡我的 Vim 設定的話，可以使用以下方式進行安裝：

### 方法一：手動安裝

先備份原本的 `.vimrc`、`.gvimrc` 以及 `.vim` 目錄，然後進行以下程序：

    $ cd ~
    $ git clone https://github.com/kaochenlong/cch.git .vim
    $ ln -s .vim/vimrc .vimrc
    $ ln -s .vim/gvimrc .gvimrc

最後開啟 Vim，並執行 `:PlugInstall` 指令安裝外掛程式。

### 方法二：快速安裝

如果你信得過我的話，你可以在終端機環境直接貼上並執行以下這段程式：

1. 使用 `curl`：

```
$ sh <(curl -L https://github.com/kaochenlong/cch/raw/master/utils/install.sh)
```

2. 使用 `wget`： 

```
$ sh <(wget --no-check-certificate https://github.com/kaochenlong/cch/raw/master/utils/install.sh -O -)
```
