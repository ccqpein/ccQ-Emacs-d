;;;;;;;; Javascript mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package js
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-mode))
  (straight-use-package 'js2-mode)
  
  :hook
  (
   (js-mode . hs-minor-mode)
   ;;(js-mode . js2-minor-mode)
   ;;(js-mode . (lambda () (setq js-indent-level 2)))
   (js-mode . lsp-deferred)
   )
  )

(provide 'init-js)
