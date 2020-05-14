# README

Personal Emacs configure 

My environment:

  * Emacs 27
  * macOS

All configure files store in `~/.emacs.d` that Emacs default path.

## Usage

### Install

Install emacs, I install from source code by using `install.sh` of this repo:

```
sbcl --load ./install.lisp
```

Run script to install all packages 

`emacs -q --script install-packages.el`

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
	- [gopls](https://github.com/golang/tools/tree/master/gopls) for lsp
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
+ coq 
+ elm
  - elm-oracle
+ julia
   
## About LSP ##

LSP configuration in `lisp/init-lsp.el`

**Golang**

Use [Gopls](https://github.com/golang/tools/tree/master/gopls) be my LSP

**Javascript/Typescript**

Use [typescript-language-server](https://github.com/theia-ide/typescript-language-server) be my LSP

## About ispell

I use `aspell` as `ispell` backend which installed by homebrew in my local machine. `Flyspell` config does not have single .el file, its require rule in `/lisp/init-markdown.el` 

## About org-mode
`org-agenda-files` is be set by environment variable `$ORG_PATH`

## About custom setting

The custom setting configure at the bottle of `init.el`. Focus on `jdee-jdk-registry`, you should change jdk path to your java home dir, or use `/Library/Java/Home` symbolic link instead of true jdk path.

## About Plugins

Some scripts or tools. Get more detail in plugins [README](./plugins/README.md)

## About Ag ##

`helm` uses [Ag](https://github.com/ggreer/the_silver_searcher) be "grep" implement. So I install `ag` in my local and define command in `init-helm.el`.

