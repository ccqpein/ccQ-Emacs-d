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
  
  (helm-grep-ag-command
   "ag --line-numbers -S \\
--hidden \\
--color --color-match '31;43' \\
--ignore-dir .git \\
--nogroup %s %s %s")
  (helm-grep-ag-pipe-cmd-switches '("--color-match '31;43'"))

  :config
  (helm-mode 1)
  (helm-autoresize-mode 1)
  )


;;; helm gtags use global be backend, here is ~/.globalrc example
(use-package helm-gtags
  :hook
  ((dired-mode . helm-gtags-mode)
   (eshell-mode . helm-gtags-mode)
   (c-mode . helm-gtags-mode)
   (c++-mode . helm-gtags-mode)
   (emacs-lisp-mode . helm-gtags-mode)
   (lisp-mode . helm-gtags-mode)
   (lisp-interaction-mode . helm-gtags-mode)
   (slime-repl-mode . helm-gtags-mode)
   (clojure-mode . helm-gtags-mode)
   (cider-repl-mode . helm-gtags-mode)
   (python-mode . helm-gtags-mode)
   (elpy-mode . helm-gtags-mode)
   (web-mode . helm-gtags-mode)
   (swift-mode . helm-gtags-mode)
   (haskell-mode . helm-gtags-mode)
   (scala-mode . helm-gtags-mode)
   (go-mode . helm-gtags-mode)
   (tuareg-mode . helm-gtags-mode)
   (rust-mode . helm-gtags-mode)
   (js-mode . helm-gtags-mode)
   )

  :bind
  (:map helm-gtags-mode-map
   ("C-c g a" . helm-gtags-tags-in-this-function)
   ("C-c g j" . helm-gtags-select)
   ("C-c g d" . helm-gtags-dwim)
   ("C-c g b" . helm-gtags-pop-stack)
   ("C-c <" . helm-gtags-previous-history)
   ("C-c >" . helm-gtags-next-history)
   ("M-." . nil)
   ("C-t" . nil))

  :custom
  (helm-gtags-ignore-case t)
  (helm-gtags-auto-update t)
  (helm-gtags-use-input-at-cursor t)
  (helm-gtags-pulse-at-cursor t)
  (helm-gtags-prefix-key "\C-cg")
  (helm-gtags-suggested-key-mapping t)
  )


(use-package projectile  
  :init
  (projectile-mode +1)
  
  :bind
  ("C-c p" . projectile-command-map)

  :custom
  (projectile-sort-order 'recentf)
  (projectile-enable-caching t)

  ;; change the order
  (projectile-project-root-functions
   '(projectile-root-local
     projectile-root-top-down
     projectile-root-bottom-up
     projectile-root-top-down-recurring))
  
  :config
  ;;; http://tuhdo.github.io/helm-projectile.html
  (require 'helm-projectile)
  (helm-projectile-on)

  ;; golang
  (projectile-register-project-type
   'go
   '("go.mod")
   :project-file "go.mod")

  ;;(setf projectile-project-types (seq-subseq projectile-project-types (- (length projectile-project-types) 3)))
  )


(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-c h s") 'helm-do-grep-ag)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

(provide 'init-helm)
