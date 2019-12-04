set -e

wget -v https://github.com/emacs-mirror/emacs/archive/master.zip || exit 1
unzip master.zip && cd emacs-master || exit 1

brew update && brew upgrade && brew install autoconf automake texinfo gnutls pkg-config libxml2 || exit 1

export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig" || exit 1

./autogen.sh || exit 1

./configure && gmake && gmake install && open ./nextstep || exit 1
