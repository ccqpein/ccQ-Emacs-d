# README

Personal Emacs configure 

My environment:

  * Emacs 26
  * macOS 10.14

All configure files store in `~/.emacs.d` that Emacs default path.

## Usage

### Install

First install emacs >= 25

`brew install emacs`

Make sure your emacs is install successfully.

`which emacs` -> `/usr/local/bin/emacs`

Clone to emacs.d folder

`git clone https://github.com/ccqpein/ccQ-Emacs-d.git ~/.emacs.d`

Run script to install all packages 

`emacs -q --script install-packages.el`

or run `install-packages.el` directly.

## Languages Supported and System Dependency
List all languages support and the dependencies that need install in system. All packages which Emacs need in [packages](./packages) file.

+ Common Lisp
    - SBCL 
+ Clojure
    - lein
	- clojure
+ Tex
    - mactex
+ Markdown
+ Java (not write for a long while)
    - jdk
+ Python
	- ipython
	- autopep8
+ Golang
	- [gocode](https://github.com/mdempsky/gocode)
+ Swift (not write for a long while)
+ Haskell
	- cabal
	- stylish-haskell (installed by cabal)
	- hasktags
	- hindent
+ Scala (not write for a long while)
	- sbt 
+ Rust
	- cargo
	- cargo-fmt
	- racer
	- rustfmt
+ HTML & PHP
+ Ocaml
	- opam
   
## About ispell

I use `aspell` as `ispell` backend which installed by homebrew in my local machine. `Flyspell` config does not have single .el file, its require rule in `/lisp/init-markdown.el` 

## About org-mode
`org-agenda-files` is be set by environment variable `$ORG_PATH`

## About custom setting

The custom setting configure at the bottle of `init.el`. Focus on `jdee-jdk-registry`, you should change jdk path to your java home dir, or use `/Library/Java/Home` symbolic link instead of true jdk path.

## About Plugins

Some scripts or tools. Get more detail in plugins [README](./plugins/README.md)

