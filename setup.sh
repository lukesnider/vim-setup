#!/bin/sh

ROOT=$(pwd)
PACKDIR=$ROOT/pack/andmatand

# Make directories which vimrc expects to exist
mkdir -p $ROOT/tmp
mkdir -p $ROOT/undo

# Make a directory for startup packages
mkdir -p $PACKDIR/start
cd $PACKDIR/start

# Install startup packages
git clone https://github.com/dyng/ctrlsf.vim.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/haya14busa/vim-asterisk.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/mhinz/vim-signify.git
git clone https://github.com/morhetz/gruvbox.git
git clone https://github.com/ntpeters/vim-better-whitespace.git
git clone https://github.com/qpkorr/vim-renamer.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/tpope/vim-vinegar.git
git clone https://github.com/w0rp/ale.git
git clone https://github.com/will133/vim-dirdiff.git

# Make a directory for optional packages
mkdir -p $PACKDIR/opt
cd $PACKDIR/opt

# Install optional packages
git clone https://github.com/JamshedVesuna/vim-markdown-preview.git
