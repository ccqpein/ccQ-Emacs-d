;;; init file
(require 'package)

;; update 2/16/2019, temporary delete default gnu source because cannot refresh
(setq package-archives '(
 ("melpa" . "https://melpa.org/packages/")
 ("melpa-stable" . "https://stable.melpa.org/packages/")
 ("gnu" . "https://elpa.gnu.org/packages/")
 ))

(dolist (path '("~/.emacs.d/elpa"
				"~/.emacs.d/plugins/"
				"~/.emacs.d/lisp/"
				
				;; opam_link is local alias be created by opam switch.
				;; so I do not need to change site-lisp after update opam switch
				;; opam switch link <switch version> ~/.emacs.d/opam_link
				"~/.emacs.d/opam_link/_opam/share/emacs/site-lisp/"
				"/usr/local/share/emacs/site-lisp/"
                ))
  (add-to-list 'load-path path))

(setq package-enable-at-startup nil)
(package-initialize)


;;;;;;;;;; set frame default ;;;;;;;;;;;;;;;
(add-to-list 'default-frame-alist '(width . 110))
(add-to-list 'default-frame-alist '(height . 71))
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
(load-theme 'monokai t)


;;;;;; use-package ;;;;;;;;;;;;
(eval-when-compile (require 'use-package))


;;;;;;; autocomplete ;;;;;;
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(global-auto-complete-mode t)


;;;;;;; flycheck ;;;;;;;
(global-flycheck-mode)
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)


;;;;;;; company ;;;;;;;;
;; looks like company mode do not need to load as global
;; most of modes have already load it in backend
;(global-company-mode)


;;;;;;; yasnippet ;;;;;;
(require 'yasnippet)
(yas-global-mode 1)


;;;;;;;; multiple-cursors ;;;;;;;;;;;;;;;;
(require 'multiple-cursors)
(global-set-key (kbd "M-\\") 'mc/edit-lines)
(global-set-key (kbd "M-]") 'mc/mark-next-like-this)
(global-set-key (kbd "M-[") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c M-p") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-\\") 'mc/mark-all-in-region)


;;;;;;;; highlight-symbol ;;;;;;;;;;;;;;;;;;
(require 'highlight-symbol)
(global-set-key (kbd "C-M-]") 'highlight-symbol-next)
(global-set-key (kbd "C-M-[") 'highlight-symbol-prev)


;;;;;;;; expand-region ;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(delete-selection-mode 1)


;;;;;; Google ;;;;;;;;;;;;;;;;
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "C-c /") 'google-this-mode-submap)


;;;;;; Magit ;;;;;;;
(require 'magit)
(global-set-key (kbd "C-x M-G") 'magit-dispatch-popup)
(global-set-key (kbd "C-x M-g") 'magit-status)


(require 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)

;; windmove
(global-set-key (kbd "s-<left>")  'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>")    'windmove-up)
(global-set-key (kbd "s-<down>")  'windmove-down)


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

;(require 'init-scala)

(require 'init-rust)

(require 'init-yaml)

(require 'init-ocaml)

(require 'init-coq)

(require 'init-gc)

(require 'init-elm)

(require 'init-groovy)

(require 'init-lsp)


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
   '(lsp-sourcekit helm-core helm-lsp lsp-treemacs company-lsp lsp-ui groovy-mode elm-mode flycheck-elm flycheck-haskell company-coq proof-general graphviz-dot-mode cargo ac-slime merlin utop tuareg yaml-mode helm-swoop use-package restclient treemacs flycheck-rust lsp-mode racer rust-mode highlight-symbol monokai-theme ensime tide helm-gtags helm ac-cider cider clojure-mode auctex magit js2-mode web-mode swiper swift-mode slime py-autopep8 pkg-info paredit multiple-cursors markdown-mode jdee hindent haskell-mode google-this go-mode expand-region exec-path-from-shell elpy dash-at-point better-defaults ac-php))
 '(recentf-max-saved-items 10)
 '(send-mail-function 'mailclient-send-it)
 '(visible-bell nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t (:inherit highlight :background "SkyBlue4"))))
 '(show-paren-match ((t (:foreground "#A6E22E" :inverse-video t :weight normal)))))
