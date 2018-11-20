#! /bin/bash

# 一行命令安装
# curl https://raw.githubusercontent.com/imbakn/tiny-smart/master/install.sh -L -o - | sh

INSTALL_PATH=~/.smart

do_backup() {
    if [ -e "$1" ]; then
        today=`date +%Y%m%d_%s`
        [ -e "$1" ] && [ ! -L "$1" ] && sudo mv -v "$1" "$i.$today";
        ret="$?"
   fi
}

if [ ! -f $INSTALL_PATH/install.sh ] && [ ! -f $INSTALL_PATH/main.rc ] ; then
    mv ~/.smart ~/.smart.bak
    git clone https://github.com/imbakn/tiny-smart ~/.smart
fi

cd ~/.smart && git submodule init && git submodule update

# 安装 fzf
~/.smart/modules/fzf/install

[ -f ~/.bashrc ] && echo 'export SMART_SHELL=bash' >> ~/.bashrc
[ -f ~/.bashrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.bashrc

[ -f ~/.zshrc ] && echo 'export SMART_SHELL=zsh' >> ~/.zshrc
[ -f ~/.zshrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.zshrc

