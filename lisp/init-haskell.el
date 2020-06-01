;;;;;;;;; Haskell ;;;;;;;;;;;;;
;; need installed `hindent` `stylish-haskell`
(use-package haskell-mode
  :ensure t

  :bind
  (:map haskell-mode-map
		("C-c C-l" . haskell-process-load-or-reload)
		("C-`" . haskell-interactive-bring)
		("C-c C-z" . haskell-interactive-bring)
		("C-c C-t" . haskell-process-do-type)
		("C-c C-i" . haskell-process-do-info)
		("C-c C-c" . haskell-process-cabal-build)
		("C-c C-k" . haskell-interactive-mode-clear)
		("C-c c" . haskell-process-cabal)
		("C-;" . comment-dwim))

  :custom
  (haskell-process-type 'cabal-new-repl)
  ;;(haskell-process-type 'cabal-repl)
  ;;(haskell-process-type 'ghci)
  
  :config
  (setq haskell-stylish-on-save t)
  (setq flycheck-ghc-package-databases ;; set package database to the list of package.db
        (mapcar (lambda (p)
                  (concat p "/package.db/"))
                (directory-files (concat (getenv "HOME") "/.cabal/store") t ".*[^.]$")))
  
  :hook
  (
   (haskell-mode . hindent-mode)
   (haskell-mode . interactive-haskell-mode)
   )
  )

(provide 'init-haskell)

;;; 2018-09-13
;;; because I choice to use `use-package` to loading package
;;; code below are obsolete

;(require 'haskell-mode)
;(require 'hindent)
;(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;(add-hook 'haskell-mode-hook 'hindent-mode)
;(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
;(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
;(provide 'init-haskell)
