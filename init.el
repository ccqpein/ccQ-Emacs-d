;;; init file
(require 'package)

;; update 2/16/2019, temporary delete default gnu source because cannot refresh
(setq package-archives
      '(
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ;;("gnu" . "https://elpa.gnu.org/packages/")
        ))

(dolist (path '("~/.emacs.d/elpa"
				"~/.emacs.d/plugins/"
				"~/.emacs.d/lisp/"
				
				;; opam_link is local alias be created by opam switch.
				;; so I do not need to change site-lisp after update opam switch
				;; opam switch link <switch version> ~/.emacs.d/opam_link
				"~/.emacs.d/opam_link/_opam/share/emacs/site-lisp/"
                ))
  (add-to-list 'load-path path))

;;; add all subdirs in load path
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(setq comp-deferred-compilation t)
(package-initialize)


;;;;;;;;;; set frame default ;;;;;;;;;;;;;;;
(add-to-list 'default-frame-alist '(width . 93))
(add-to-list 'default-frame-alist '(height . 60))
(global-hl-line-mode 1)
(global-display-line-numbers-mode)
;; close bars
;; settings below might just works when emacs installed with-cocoa (by brewcask)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 1)
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(setq backup-directory-alist '(("" . "~/.emacs.d/backups")))
(defalias 'list-buffers 'ibuffer) ; make ibuffer default


;;;;;; Styling and Themes ;;;;;;;
(load-theme 'solarized-dark t)


;;;;;; use-package ;;;;;;;;;;;;
(eval-when-compile (require 'use-package))


;;;;;;; autocomplete ;;;;;;
(ac-config-default)

(global-auto-complete-mode t)


;;;;;;; flycheck ;;;;;;;
(global-flycheck-mode)
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)


;; windmove
(global-set-key (kbd "s-<left>")  'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>")    'windmove-up)
(global-set-key (kbd "s-<down>")  'windmove-down)

(require 'init-general)

;;; other modes
(require 'init-external)

;;; languages
(require 'init-treemacs)

(require 'init-lisp)

(require 'init-shell)

(require 'init-helm)

(require 'init-tex)

(require 'init-dash)

(require 'init-org)

(require 'init-markdown)

;(require 'init-java)

(require 'init-python)

(require 'init-golang)

(require 'init-swift)

(require 'init-haskell)

(require 'init-typescript)

(require 'init-web-n-php)

(require 'init-js)

(require 'init-julia)

(require 'init-rust)

(require 'init-yaml)

;;(require 'init-ocaml)

(require 'init-coq)

(require 'init-gc)

(require 'init-elm)

(require 'init-groovy)

(require 'init-lsp)

(require 'init-c)

(require 'init-custom)


;;;;;;;;;;; custom setting;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(expand-region-smart-cursor t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(jdee-compiler '("javac"))
 '(jdee-jdk-registry '(("1.8" . "/Library/Java/Home")))
 '(magit-diff-arguments '("--no-ext-diff" "--stat"))
 '(markdown-command "~/.emacs.d/plugins/open-markdown-to-web.sh")
 '(markdown-open-command "~/.emacs.d/plugins/open-markdown-marked2.sh")
 '(package-selected-packages
   '(solarized-theme dap-mode helm-ag helm-projectile clang-format company-jedi julia-mode julia-repl magit json-mode projectile lsp-sourcekit helm-core helm-lsp lsp-treemacs lsp-ui groovy-mode elm-mode flycheck-elm flycheck-haskell company-coq proof-general graphviz-dot-mode cargo ac-slime merlin utop tuareg yaml-mode use-package restclient treemacs flycheck-rust lsp-mode racer rust-mode highlight-symbol tide helm-gtags helm ac-cider cider clojure-mode auctex js2-mode web-mode swiper swift-mode slime py-autopep8 pkg-info paredit multiple-cursors markdown-mode jdee hindent haskell-mode google-this go-mode expand-region exec-path-from-shell elpy dash-at-point better-defaults ac-php))
 '(recentf-max-saved-items 10)
 '(send-mail-function 'mailclient-send-it)
 '(visible-bell nil)
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; You can use `C-u C-x =’ to find out which faces are applied to the text at point (under the cursor).
 '(lsp-face-highlight-textual ((t (:inherit highlight :background "orange4"))))
 '(region ((t (:inherit highlight :background "SkyBlue4"))))
 '(show-paren-match ((t (:foreground "#A6E22E" :inverse-video t :weight normal)))))
