# README

This folder include some useful scripts.

### eems.sh

Run emacsclient

```bash
#run emacs server
emacs --daemon

#stop emacs server
emacsclient --eval "(kill-emacs)"

#run emacs client
eems.sh
```

### jdee-server

### open-markdown-to-web.sh

Need change configuration to fit your environment

### open-markdown-marked2.sh

Need Marked 2

### opam-user-setup ###

opam stuff

### update-rust-analyzer.lisp ###

common lisp script to update and install rust-analyzer.

`sbcl --load update-rust-analyzer.lisp`
