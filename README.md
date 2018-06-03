# README

Personal Emacs configure 

My environment:

  * Emacs 26
  * macOS 10.13

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
+ Tex
    - mactex
+ Markdown
+ Java
    - jdk
+ Python
	- ipython
	- autopep8
+ Golang
+ Swift
+ Haskell
	- cabal
+ Scala (still working on)
	- sbt 
+ Rust
+ HTML & PHP

## About org-mode
`org-agenda-files` is be set by environment variable `$ORG_PATH`

## About custom setting

The custom setting configure at the bottle of `init.el`. Focus on `jdee-jdk-registry`, you should change jdk path to your java home dir, or use `/Library/Java/Home` symbolic link instead of true jdk path.

## About Plugins

Some scripts or tools. Get more detail in plugins [README](./plugins/README.md)

