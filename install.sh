# cd emacs source code and run this 
brew update && brew install autoconf automake texinfo gnutls pkg-config libxml2

 export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

./autogen.sh

./configure && gmake && gmake install && open ./nextstep
