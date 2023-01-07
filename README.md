# README

- [Usage](#usage)
  - [Install](#install)
  - [Languages Supported and System Dependency](#languages-supported-and-system-dependency)
- [About](#about)
  - [About LSP](#about-lsp)
  - [About ispell](#about-ispell)
  - [About org-mode](#about-orgmode)
  - [About custom setting](#about-custom-setting)
  - [About Plugins](#about-plugins)
  - [About Ag](#about-ag)
  - [About forge](#about-forge)
  - [About tree-sitter (treesit)](#about-tree-sitter-treesit)
    
Personal Emacs configure 

My environment:

  * Emacs master branch (check [Install](#install))
  * macOS

All configure files store in `~/.emacs.d` that Emacs default path.

## Usage

### Install

Use [this repo](github.com/jimeh/build-emacs-for-macos.git) to compile emacs in my local.

Run script to install all packages 

`emacs -q --script install-packages.el`

### Languages Supported and System Dependency ###

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
+ C/Cpp
  - gcc install by homebrew, flycheck settings in `lisp/init-c.el`
   
## About ##

### About LSP ###

LSP configuration in `lisp/init-lsp.el`

**Golang**

Use [Gopls](https://github.com/golang/tools/tree/master/gopls) be my LSP

**Javascript/Typescript**

Use [deno](https://deno.land/#installation) be my LSP

**Rust**

Use [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer) be Rust LSP. Update/Install it by using `sbcl --load ./plugins/update-rust-analyzer-v2.lisp`. You need has `sbcl` and `quicklisp` installed.

### About ispell ###

I use `aspell` as `ispell` backend which installed by homebrew in my local machine. `Flyspell` config does not have single .el file, its require rule in `/lisp/init-markdown.el` 

### About org-mode ###

`org-agenda-files` is be set by environment variable `$ORG_PATH`

### About custom setting ###

The custom setting configure at the bottle of `init.el`. Focus on `jdee-jdk-registry`, you should change jdk path to your java home dir, or use `/Library/Java/Home` symbolic link instead of true jdk path.

### About Plugins ###

Some scripts or tools. Get more detail in plugins [README](./plugins/README.md)

### About Ag ###

`helm` uses [Ag](https://github.com/ggreer/the_silver_searcher) be "grep" implement. So I install `ag` in my local and define command in `init-helm.el`.

### About forge ###

<code>[forge](https://github.com/magit/forge)</code> is the package binding with magit for getting details from Github of this repo. 

Several configurations links:

- [blog](https://practical.li/spacemacs/source-control/forge-configuration.html)
- [Forge User and Developer Manual](https://magit.vc/manual/forge.html)

For me, I just make `~/.authinfo` like 

`machine api.github.com login {username}^forge password {github_token}`

### About tree-sitter (treesit) ###

I use [tree-sitter-module](https://github.com/casouri/tree-sitter-module.git) build the `tree-sitter` libraries. 

Then move the `dylib` files to the `treesit-extra-load-path` (`"~/.emacs.d/tree-sitter-libs/")`, which set in `lisp/init-custom.el`)

