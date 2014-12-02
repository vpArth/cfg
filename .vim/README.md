vim config repo
===============

Installation:
--------------

```bash
DIR=~/.vim
rm -rf $DIR
git clone https://github.com/vpArth/vim.git $DIR
cd $DIR
git submodules update
ln -sf ~/.vimrc $DIR/.vimrc

sudo apt-get install exuberant-ctags
