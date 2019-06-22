# cd emacs source code and run this 
brew update && brew install autoconf automake texinfo gnutls pkg-config libxml2

export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"

./autogen.sh

./configure && make && make install && open ./nextstep
