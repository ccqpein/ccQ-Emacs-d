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

  ;; https://github.com/emacs-helm/helm/issues/2175
  ;; back helm to old age
  ;; update on 5/24/2020: looks like he change it back..
  ;; ..no need custom settings below anymore
  ;; :custom
  ;; (helm-ff-lynx-style-map t)
  ;; (helm-imenu-lynx-style-map t)
  ;; (helm-semantic-lynx-style-map t)
  ;; (helm-occur-use-ioccur-style-keys t)

  ;; :bind
  ;; (:map helm-map
  ;;       ("<left>" . helm-previous-source)
  ;;       ("<right>" . helm-next-source))
  
  :config
  (require 'helm-config)
  (helm-mode 1)
  (helm-autoresize-mode t)
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
   ("M-." . helm-gtags-dwim)
   ("M-," . helm-gtags-pop-stack)
   ("C-c <" . helm-gtags-previous-history)
   ("C-c >" . helm-gtags-next-history))

  :custom
  (helm-gtags-ignore-case t)
  (helm-gtags-auto-update t)
  (helm-gtags-use-input-at-cursor t)
  (helm-gtags-pulse-at-cursor t)
  (helm-gtags-prefix-key "\C-cg")
  (helm-gtags-suggested-key-mapping t)
  )

(use-package projectile
  :hook
  ((helm-gtags-mode . projectile-mode))
  
  :bind-keymap
  ("C-c p" . projectile-command-map)
  
  :config
  (defun projectile-ag (arg)
    (interactive "P")
    (helm-grep-ag (projectile-project-root) arg))
  )

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-c h s") 'helm-do-grep-ag)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

(provide 'init-helm)
