from initxyz.common.ensure import *

zsh.enable()
zsh.prepend_path('/usr/local/bin')
zsh.prepend_path('~/bin')
zsh.prepend_path('~/.initxyz/configs/bin')
zsh.prepend_path('~/init.xyz/bin')
zsh.include('init.zsh')

apt.require('git', 'nano', 'htop', 'zsh', 'ccache', 'build-essential', 'expect', 'cabal-install', 'clang', 'ipython3', 'ipython', 'wget', 'command-not-found', 'ack-grep', 'strace', 'psmisc', 'unzip', 'man-db')

mkdir('~/bin')
mkdir('~/.ssh')

if not apt.is_installed('emacs24') and not apt.is_installed('emacs24-nox'):
    apt.require('emacs24-nox')

