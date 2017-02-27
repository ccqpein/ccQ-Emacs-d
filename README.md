# README

Personal Emacs configure 

My environment:

  * Emacs 25.1
  * macOS 10.12.3

All configure files store in `~/.emacs.d` that Emacs default path.

## Usage

### Install

First clone to emacs.d folder

`git clone https://github.com/ccqpein/ccQ-Emacs-d.git ~/.emacs.d`

Run script to install all packages 

`emacs --script install-packages.el`

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
+ Golang
+ Swift
+ Haskell
+ HTML & PHP

## About custom setting

The custom setting configure at the bottle of `init.el`. Focus on `jdee-jdk-registry`, you should change jdk path to your java home dir. 

## About Plugins

Some scripts or tools. Get more detail in plugins [README](./plugins/README.md)



