# Basic

[TOC]

## Install Ubuntu
1. Use `Rufus` make UEFI bootloader in windows.
1. If reinstall ubuntu, choose `something else` during `Installation type`, and then select hardware and install.
1. Partition for ubuntu, 512M for EFI partition, 8-10G for swap, 80G ext4 partition for mounting `/`, others ext4 for mounting `/home`. Choose EFI partition for boot loader.

## Ubuntu Setting
1. `Setting/Keyboard`, search `switch`, and set the shortcut of `Switch windows` to `Super+Tab`.


## Add tsinghua Source
Modify `/etc/apt/sources.list`, see [tsinghua mirror](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/).

## Chrome
1. Install chrome.
    - Download from [chrome](http://www.chromeliulanqi.com/) or [chrome ubuntu update](https://www.ubuntuupdates.org/ppa/google_chrome)
    - Download [SwitchOmega](https://github.com/FelisCatus/SwitchyOmega/releases)
    - Modify `SwitchyOmega_Chromium.crx` to `SwitchyOmega_Chromium.zip`, and unzip to some folder.
    - Open `chrome://extensions/` in chrome, check developer mode, and `Load unpacked` from previous directory.
1. Install `Git`.
1. Install `ShadowSocks`, maybe should install `anaconda`
    ```sh{.line-numbers}
    # copy file to folder
    sudo chmod +x ./ssr 
    ./ssr install
    python3 ./select_config.py
    sudo ./ssr start
    ```
1. Log in `chrome` and synchronization
1. In ubuntu virtual system in `Parallels`, the chrome maybe show in white screen.
    - Add `--disable-gpu` to launch chrome in terminal, and then remove the GPU acceleration in setting. See [Ref1](https://blog.csdn.net/hua_faded/article/details/78748553?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-4.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-4.channel_param) and [Ref2](https://blog.csdn.net/nasohaohao/article/details/103194740?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)
    - ~~Add `--use-gl=angle` in file `/usr/share/applications/google-chrome.desktop` as below, there are 3 places should be modify.~~
        ```
        Exec=/usr/bin/google-chrome-stable --use-gl=angle
        ```


## GNOME Extension
1. ```sudo apt install chrome-gnome-shell```
1. Open [GNOME Shell integration for Chrome](https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep) to install chrome extension
1. Open [GNOME Site](https://extensions.gnome.org/) to manage and set the extensions
1. Recommend extensions:
    - Hide Top Bar
    - Clipboard Indicator
    - Screenshot Tool


## proxy
Add below contents in `/etc/apt/apt.conf`
```sh{.line-numbers}
Acquire::http::proxy "http://10.69.60.221:8080";
Acquire::ftp::proxy "ftp://10.69.60.221:8080";
Acquire::https::proxy "https://10.69.60.221:8080";
```

Please use those commands before you use pip or wget to install anything.
```sh{.line-numbers}
export http_proxy="http://10.69.60.221:8080"
export https_proxy="https://10.69.60.221:8080"
```

If apt don't working due to network connection, try create a file named `proxy` in `/etc/apt/apt.conf.d`, and add below content, please note use `http` instead `https` for `https::Proxy`
```
Acquire::http::Proxy "http://10.69.60.221:8080";
Acquire::https::Proxy "http://10.69.60.221:8080";
```

## ~~fcitx-wbpy~~

改用[百度五笔输入法](https://srf.baidu.com/site/guanwang_linux/index.html)

```sh{.line-numbers}
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx-table-wbpy
# apply Chinese as global language and restart
```


## 7z
```sh{.line-numbers}
sudo apt-get install p7zip
extract: 7z -x file.7z -r -o /home/folder
compress: 7z a -tr file.7z /home/folder/*
```

## tar, zip
```sh{.line-numbers}
tar -czf file.tar.gz ./folder
# enter directory to compress
tar -czf ../../package/data.tar.gz -C ../../package/data .
tar -zxvf file.tar.gz
unzip archive_name.zip -d ./Folder
```

## ssh
```sh{.line-numbers}
# connect to server
ssh jeffery@192.108.0.2
# copy folder
scp -rf ~/Documents/Code jeffery@192.108.0.2:/home/jeffery/Documents
# rsync, copy file exclude
rsync -arv --exclude '*.bag' jeffery@192.108.0.2:/home/jeffery/Documents/Code/CameraCalibration/ ./

# screen
screen
# Ctrl+A, ? for help
# Ctrl+A, d for detach
exit # quit screen mode
screen -ls # show detached connection
screen -r <ID> # recover

# tmux, more powerful than screen
```

## zsh
1. Install zsh
    ```sh{.line-numbers}
    sudo apt-get install zsh
    sudo apt-get install trash-cli  # trash
    ehco $SHELL     # cureent used shell
    cat /etc/shells # list shell
    chsh -s /bin/zsh    # change to zsh
    ```
    
1. Install [on-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
    ```sh{.line-numbers}
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
    
1. Add plugins

    1. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

        ```
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        ```

1. Config, modify `~/.zshrc` like below
    
    ```sh{.line-numbers}
    # Modify theme
    ZSH_THEME="agnoster"
    
    # plugins
    plugins=(git docker docker-compose zsh-syntax-highlighting)
    
    # Hide default user
    DEFAULT_USER="jeffery"
    
    # Modify rm command
    alias rm=trash
    
    # Anaconda
    export PATH="/home/jeffery/anaconda3/bin:$PATH"
    ```
    
1. Install font
    - Download [powerline fonts](https://github.com/powerline/fonts) and install
    - Change font to 'Meslo' in teminal perference, also the scheme could be changed
    
1. Reboot


## Shutter
```sh{.line-numbers}
sudo add-apt-repository ppa:linuxuprising/shutter
sudo apt install shutter
```

## uGet and aria2
```sh{.line-numbers}
sudo add-apt-repository ppa:plushuang-tw/uget-stable
sudo add-apt-repository ppa:uget-team/ppa
sudo apt update
sudo apt install uget aria2
sudo apt install uget-integrator    # for chrome integration
```


## Latex
```sh{.line-numbers}
sudo apt-get install texlive-full
# texstudio
sudo add-apt-repository ppa:sunderme/texstudio
sudo apt-get update
sudo apt-get install texstudio
# format
latexindent -w -s ./File.tex
# pandoc
pandoc ./test.tex -s -o ./test.md
```

## Zotero
1. Install based on the [offical instruction](https://www.zotero.org/support/installation#how_do_i_install_zotero)
1. Set the launcher if don't has icon
    - remove the launcher symlink (the generic icon will disappear from the launchers):
        ```sh
        rm ~/.local/share/applications/zotero.desktop
        ```
    - execute the launcher script:
        ```sh
        /opt/zotero/set_launcher_icon
        ```
    - symlink the new launcher:
        ```sh
        ln -s /opt/zotero/zotero.desktop ~/.local/share/applications/zotero.desktop
        ```
    - The launcher icon should appear in the launchers, no need to reboot.
1. Install plugin [better bibtex](https://retorque.re/zotero-better-bibtex/) ([download site](https://github.com/retorquere/zotero-better-bibtex/releases))
    - `Modify Citation keys format` in `Better BibTeX/Citation keys` to `[shorttitle3_3]_[auth]_[year]`
1. Modify config in `Preferences/Advanced/Config Editor`, search `rename`, and modify below value
    - `extensions.zotero.attachmentRenameFormatString`: `{%t{80}_}{%c_}{%y}`
    - `extensions.zotero.autoRenameFiles.linked`: `true`
    - `extensions.zotero.lastRenameAssociatedFile`: `true`
1. Log in and sync
1. Copy files in folder `storage` to this computer.