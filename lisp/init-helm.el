;;;;;; Helm ;;;;;;;;;;;;
(use-package helm
  :custom
  (helm-split-window-in-side-p           t)
  (helm-move-to-line-cycle-in-source     t)
  (helm-ff-search-library-in-sexp        t)
  (helm-M-x-fuzzy-match                  t)
  (helm-buffers-fuzzy-matching           t)
  (helm-locate-fuzzy-match               t)
  (helm-recentf-fuzzy-match              t)
  (helm-semantic-fuzzy-match             t)
  (helm-imenu-fuzzy-match                t)
  (helm-scroll-amount                    8)
  (helm-ff-file-name-history-use-recentf t)

  :config
  (require 'helm-config)
  (helm-mode 1)
  (helm-autoresize-mode t)
  )


(use-package helm-gtags-mode
  :bind
  (("C-c g a" . helm-gtags-tags-in-this-function)
   ("C-c g j" . helm-gtags-select)
   ("M-." . helm-gtags-dwim)
   ("M-," . helm-gtags-pop-stack)
   ("C-c <" . helm-gtags-previous-history)
   ("C-c >" . helm-gtags-next-history))

  :hook
  (
   dired-mode
   eshell-mode
   c-mode
   c++-mode
   emacs-lisp-mode
   lisp-mode
   lisp-interaction-mode
   slime-repl-mode
   clojure-mode
   cider-repl-mode
   python-mode
   elpy-mode
   web-mode
   swift-mode
   haskell-mode
   scala-mode
   go-mode
   )
  
  :custom
  (helm-gtags-ignore-case t)
  (helm-gtags-auto-update t)
  (helm-gtags-use-input-at-cursor t)
  (helm-gtags-pulse-at-cursor t)
  (helm-gtags-prefix-key "\C-cg")
  (helm-gtags-suggested-key-mapping t)
  )


;(require 'helm)
;(require 'helm-config)
;(helm-mode 1)
;(helm-autoresize-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

;(setq helm-split-window-in-side-p           t
;      helm-move-to-line-cycle-in-source     t
;      helm-ff-search-library-in-sexp        t
;      helm-M-x-fuzzy-match                  t
;      helm-buffers-fuzzy-matching           t
;      helm-locate-fuzzy-match               t
;      helm-recentf-fuzzy-match              t
;      helm-semantic-fuzzy-match             t
;      helm-imenu-fuzzy-match                t
;      helm-scroll-amount                    8
;      helm-ff-file-name-history-use-recentf t)

;(setq
; helm-gtags-ignore-case t
; helm-gtags-auto-update t
; helm-gtags-use-input-at-cursor t
; helm-gtags-pulse-at-cursor t
; helm-gtags-prefix-key "\C-cg"
; helm-gtags-suggested-key-mapping t
; )

;(require 'helm-gtags)

;(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;(define-key helm-gtags-mode-map (kbd "C-c g j") 'helm-gtags-select)
;(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
;(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
;(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;; Enable helm-gtags-mode
;(add-hook 'dired-mode-hook 'helm-gtags-mode)
;(add-hook 'eshell-mode-hook 'helm-gtags-mode)
;(add-hook 'c-mode-hook 'helm-gtags-mode)
;(add-hook 'c++-mode-hook 'helm-gtags-mode)
;(add-hook 'emacs-lisp-mode-hook 'helm-gtags-mode)
;(add-hook 'lisp-mode-hook 'helm-gtags-mode)
;(add-hook 'lisp-interaction-mode-hook 'helm-gtags-mode)
;(add-hook 'slime-repl-mode-hook 'helm-gtags-mode)
;(add-hook 'clojure-mode-hook 'helm-gtags-mode)
;(add-hook 'cider-repl-mode-hook 'helm-gtags-mode)
;(add-hook 'python-mode-hook 'helm-gtags-mode)
;(add-hook 'elpy-mode-hook 'helm-gtags-mode)
;(add-hook 'web-mode-hook 'helm-gtags-mode)
;(add-hook 'swift-mode-hook 'helm-gtags-mode)
;(add-hook 'haskell-mode-hook 'helm-gtags-mode)
;(add-hook 'scala-mode-hook 'helm-gtags-mode)
;(add-hook 'go-mode-hook 'helm-gtags-mode)

(provide 'init-helm)
